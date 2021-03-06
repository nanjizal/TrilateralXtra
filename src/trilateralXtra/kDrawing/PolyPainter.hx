package trilateralXtra.kDrawing;
import kha.Framebuffer;
import kha.arrays.Float32Array;
import kha.Canvas;
import kha.Color;
import kha.FastFloat;
import kha.Font;
import kha.graphics2.ImageScaleQuality;
import kha.Image;
import kha.graphics4.PipelineState;
//import kha.graphics4.Graphics2;
import kha.graphics4.Graphics;
import kha.graphics4.BlendingOperation;
import kha.graphics4.BlendingFactor;
import kha.graphics4.ConstantLocation;
import kha.graphics4.CullMode;
import kha.graphics4.IndexBuffer;
import kha.graphics4.MipMapFilter;
import kha.graphics4.TextureAddressing;
import kha.graphics4.TextureFilter;
import kha.graphics4.TextureFormat;
import kha.graphics4.TextureUnit;
import kha.graphics4.Usage;
import kha.graphics4.VertexBuffer;
import kha.graphics4.VertexData;
import kha.graphics4.VertexStructure;
import kha.math.FastMatrix3;
import kha.math.FastMatrix4;
import kha.math.FastVector2;
import kha.math.Matrix3;
import kha.math.Matrix4;
import kha.math.Vector2;
import kha.Shaders;
import kha.simd.Float32x4;
@:enum  // note careful abstract enums brake KodeGarden?
abstract ShaderMode( Int ){
    var GradientMode = 0;
    var ImageMode = 1;
}
class PolyPainter{
    public static var bufferSize:       Int             = 100000; // need to set this high to work with lots of platforms
    static inline var vertexSizeImage:  Int             = 9;
    static inline var vertexSizeGradient: Int           = 7;
    public var projectionMatrix:               FastMatrix4;
    static var imagePipe:               PipelineState   = null;
    static var gradientPipe:            PipelineState   = null;
    static var strucImg:                VertexStructure = null;
    static var strucGrad:               VertexStructure = null;
    static var imgBufferIndex:          Int;
    static var gradBufferIndex:         Int;
    static var vertexBufferImage:       VertexBuffer;
    static var vertexBufferGradient:    VertexBuffer;
    static var verticesImg:             Float32Array;
    static var verticesGrad:            Float32Array;
    static var indexBufferImg:          IndexBuffer;
    static var indexBufferGrad:         IndexBuffer;
    static var imgLast:                 Image;
    static var vertexPosImage:          Int = 0;
    static var vertexPosGradient:       Int = 0;
    
    public var textureAddressingX:      TextureAddressing = Clamp;
    public var textureAddressingY:      TextureAddressing = Clamp;
    var shaderMode                      = ImageMode;
    var bilinear:                       Bool = false;
    var bilinearMipmaps:                Bool = false;    
    var g:                              Graphics;
    var myPipeline:                     PipelineState = null;
    var imgProjMatrix:                  ConstantLocation;
    var textureLocation:                TextureUnit;
    var gradProjMatrix:                 ConstantLocation;
    var isFramebuffer:                  Bool;
    var width:                          Int;
    var height:                         Int;
    var posImage:                       Int = 0;
    var posGradient:                    Int = 0;
    public var pipeline( get, set ):    PipelineState;
    public var sourceBlend:             BlendingFactor = BlendingFactor.Undefined;
    public var destinationBlend:        BlendingFactor = BlendingFactor.Undefined;
    var f:                    Framebuffer;
    var c:                         Canvas;
    public function new(){
        gradBufferIndex = 0;
        imgBufferIndex  = 0;
        initShaders();
        initBuffers();
        imgProjMatrix   = imagePipe.getConstantLocation( "projectionMatrix" );
        gradProjMatrix  = gradientPipe.getConstantLocation( "projectionMatrix" );
        textureLocation = imagePipe.getTextureUnit( "tex" );
    }
    public function begin( shaderMode_: ShaderMode, clear: Bool = true, clearColor: Color = null ): Void {
        if( g == null ) return;
        shaderMode = shaderMode_;
        g.begin();
        if ( clear ) g.clear( clearColor );
        getProjectionMatrix();
    }
    public function changeShaderMode( shaderMode_: ShaderMode ): Void {
        if( shaderMode != shaderMode_ ){
            shaderMode = shaderMode_;
            flush();
        }
    }
    public function clear( color: Color = null ): Void {
        if( g == null ) return;
        drawBuffer();
        g.clear( color == null ? Color.Black : color );
    }
    public function end(){
        if( g == null ) return;
        flush();
        g.end();
    }
    public function setProjection( projectionMatrix: FastMatrix4 ): Void {
        this.projectionMatrix = projectionMatrix;
    }
    static function upperPowerOfTwo( v: Int ): Int {
        v--;
        v |= v >>> 1;
        v |= v >>> 2;
        v |= v >>> 4;
        v |= v >>> 8;
        v |= v >>> 16;
        v++;
        return v;
    }
    static function initShaders():Void {
        if( strucImg == null ) {
            strucImg                        = new VertexStructure();
            strucImg.add( "vertexPosition",  VertexData.Float3 );
            strucImg.add( "texPosition",     VertexData.Float2 );
            strucImg.add( "vertexColor",     VertexData.Float4 );
        }
        if( imagePipe == null ){
            imagePipe                        = new PipelineState();
            imagePipe.fragmentShader         = Shaders.painter_image_frag;
            imagePipe.vertexShader           = Shaders.painter_image_vert;
            imagePipe.inputLayout            = [ strucImg ];
            imagePipe.blendSource            = BlendingFactor.BlendOne;
            imagePipe.alphaBlendSource       = BlendingFactor.BlendOne;
            imagePipe.blendDestination       = BlendingFactor.InverseSourceAlpha;
            imagePipe.alphaBlendDestination  = BlendingFactor.InverseSourceAlpha;
            imagePipe.compile();
        }
        if( strucGrad == null ) {
            strucGrad                         = new VertexStructure();
            strucGrad.add( "vertexPosition",  VertexData.Float3 );
            strucGrad.add( "vertexColor",     VertexData.Float4 );
        }
        if( gradientPipe == null ) {
            gradientPipe                       = new PipelineState();
            gradientPipe.fragmentShader        = Shaders.painter_colored_frag;
            gradientPipe.vertexShader          = Shaders.painter_colored_vert;
            gradientPipe.inputLayout           = [ strucGrad ];
            gradientPipe.blendSource           = BlendingFactor.SourceAlpha;
            gradientPipe.alphaBlendSource      = BlendingFactor.SourceAlpha;
            gradientPipe.blendDestination      = BlendingFactor.InverseSourceAlpha;
            gradientPipe.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
            gradientPipe.compile();
        }
    }
    function get_pipeline(): PipelineState {
        return myPipeline;
    }
    function set_pipeline( pipe: PipelineState ): PipelineState {
        if(pipe != myPipeline)
        flush();
        
        if( pipe == null ) {
            imgProjMatrix   = imagePipe.getConstantLocation( "projectionMatrix" );
            textureLocation = imagePipe.getTextureUnit( "tex" );
        } else if( pipe == gradientPipe ){
            imgProjMatrix   = pipe.getConstantLocation( "projectionMatrix" );
        } else {
            imgProjMatrix   = pipe.getConstantLocation( "projectionMatrix" );
            textureLocation = pipe.getTextureUnit( "tex" );
        }
        return myPipeline = pipe;
    }
    function initBuffers(): Void {
        if( vertexBufferImage == null ) {
            vertexBufferImage = new VertexBuffer( bufferSize, strucImg, Usage.DynamicUsage );
            verticesImg     = vertexBufferImage.lock();
            indexBufferImg  = new IndexBuffer( bufferSize*3, Usage.StaticUsage );
            var indicesImage  = indexBufferImg.lock();
            for( i in 0...bufferSize*3 ) {
                indicesImage[ i * 3 ]     = i *3;
                indicesImage[ i * 3 + 1 ] = i *3 + 1;
                indicesImage[ i * 3 + 2 ] = i *3 + 2;
            }
            indexBufferImg.unlock();
        }
        if( vertexBufferGradient == null ){
            vertexBufferGradient = new VertexBuffer( bufferSize, strucGrad, Usage.DynamicUsage );
            verticesGrad     = vertexBufferGradient.lock();
            indexBufferGrad  = new IndexBuffer( bufferSize*3, Usage.StaticUsage );
            var indicesGradient  = indexBufferGrad.lock();
            for( i in 0...bufferSize*3 ){
                indicesGradient[ i * 3 ]     = i *3;
                indicesGradient[ i * 3 + 1 ] = i *3 + 1;
                indicesGradient[ i * 3 + 2 ] = i *3 + 2;
            }
            indexBufferGrad.unlock();
        }
    }
    public function drawFillTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                    ,     color: Color, alpha: Float = 1. ){
        drawGradientTriangle( ax, ay, bx, by, cx, cy, color, color, color, alpha );
    }
    public inline function drawGradientTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                    ,     color0: Color, color1: Color, color2: Color, alpha: Float = 1. ){
        //if( shaderMode == ImageMode ) flush();
        if( alpha != 1. ){
            color0.A = alpha;
            color1.A = alpha;
            color2.A = alpha;
        }
        var pos = posGradient;
        verticesGrad.set( pos, ax );
        verticesGrad.set( pos +  1, ay );
        verticesGrad.set( pos +  2, -5.0 );
        verticesGrad.set( pos +  3, color0.R );
        verticesGrad.set( pos +  4, color0.G );
        verticesGrad.set( pos +  5, color0.B );
        verticesGrad.set( pos +  6, color0.A );
        verticesGrad.set( pos +  7, bx );
        verticesGrad.set( pos +  8, by );
        verticesGrad.set( pos +  9, -5.0 );
        verticesGrad.set( pos +  10, color1.R );
        verticesGrad.set( pos +  11, color1.G );
        verticesGrad.set( pos +  12, color1.B );
        verticesGrad.set( pos +  13, color1.A );
        verticesGrad.set( pos +  14, cx );
        verticesGrad.set( pos +  15, cy );
        verticesGrad.set( pos +  16, -5.0 );
        verticesGrad.set( pos +  17, color2.R );
        verticesGrad.set( pos +  18, color2.G );
        verticesGrad.set( pos +  19, color2.B );
        verticesGrad.set( pos +  20, color2.A );
        posGradient = pos + 21;
        gradBufferIndex++;
    }
    public function drawImage( img: Image, ?x: Float = 0, ?y: Float = 0, ?w: Null<Float>, ?h: Null<Float>, ?alpha: Float = 1. ){
        if( w == null ) w = img.width;
        if( h == null ) h = img.height;
        drawImageTriangle( x, y, x+w, y, x+w, y+h, 0, 0, 1, 0, 1, 1, img, alpha );
        drawImageTriangle( x, y, x+w, y+h, x, y+h, 0, 0, 1, 1, 0, 1, img, alpha );
    }
    public function drawImageTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                    ,  au: Float, av: Float, bu: Float, bv: Float, cu: Float, cv: Float
                                    , img: Image, ?alpha: Float = 1.){
        var color = Color.White;
        if( alpha != 1. ) color.A = alpha;
        drawImageTriangleGradient( ax, ay, bx, by, cx, cy, au, av, bu, bv, cu, cv, img, color, color, color );
    }
    public inline
    function drawImageGridItemColor( img: Image, col: Float, row: Float
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, color: Color = Color.White, alpha: Float = 1. ){
        var scale = 1/imageScale;
        var canvasScale = imageScale;
        var img1W = 1/img.width;
        var img1H = 1/img.height;
        x /= canvasScale;
        y /= canvasScale;
        col = ( col  )*gridW - x;
        row = ( row  )*gridH - y;
        var ax = canvasScale*( x );
        var ay = canvasScale*( y );
        var bx = canvasScale*( ( x + gridW ) );
        var by = canvasScale*( y );
        var cx = canvasScale*( ( x + gridW ) );
        var cy = canvasScale*( ( y + gridH ) );
        var au = ( ax * scale + col )*img1W;
        var av = ( ay * scale + row )*img1H;
        var bu = ( bx * scale + col )*img1W;
        var bv = ( by * scale + row )*img1H;
        var cu = ( cx * scale + col )*img1W;
        var cv = ( cy * scale + row )*img1H;
        drawImageTriangleGradient( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, color, color, color, alpha );
        by = canvasScale*( ( y + gridH ) );
        cx = canvasScale*( x );
        bv = ( by * scale + row )*img1H;
        cu = ( cx * scale + col )*img1W;
        drawImageTriangleGradient( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, color, color, color, alpha );
    }
    public inline
    function drawImageGridIndexColor( img: Image, id: Int
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, color: Color = Color.White, alpha: Float = 1. ){
        var colTot: Float = Math.floor( img.width/gridW ) + 1;
        var rowTot: Float = Math.floor( img.height/gridH ) + 1;
        var row: Float = Math.floor( id/colTot );
        var col: Float = id - row*colTot;
        drawImageGridItemColor( img, col, row, x, y, gridW, gridH, imageScale, color, alpha );
    }
    
    
    public inline
    function drawImageGridItem( img: Image, col: Float, row: Float
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, alpha: Float = 1. ){
        var scale = 1/imageScale;
        var canvasScale = imageScale;
        var img1W = 1/img.width;
        var img1H = 1/img.height;
        x /= canvasScale;
        y /= canvasScale;
        col = ( col  )*gridW - x;
        row = ( row  )*gridH - y;
        var ax = canvasScale*( x );
        var ay = canvasScale*( y );
        var bx = canvasScale*( ( x + gridW ) );
        var by = canvasScale*( y );
        var cx = canvasScale*( ( x + gridW ) );
        var cy = canvasScale*( ( y + gridH ) );
        var au = ( ax * scale + col )*img1W;
        var av = ( ay * scale + row )*img1H;
        var bu = ( bx * scale + col )*img1W;
        var bv = ( by * scale + row )*img1H;
        var cu = ( cx * scale + col )*img1W;
        var cv = ( cy * scale + row )*img1H;
        drawImageTriangle( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, alpha );
        by = canvasScale*( ( y + gridH ) );
        cx = canvasScale*( x );
        bv = ( by * scale + row )*img1H;
        cu = ( cx * scale + col )*img1W;
        drawImageTriangle( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, alpha );
    }
    public inline
    function drawImageGridIndex( img: Image, id: Int
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, alpha: Float = 1. ){
        var colTot: Float = Math.floor( img.width/gridW );
        var rowTot: Float = Math.floor( img.height/gridH );
        var row: Float = Math.floor( id/colTot );
        var col: Float = id - row*colTot;
        drawImageGridItem( img, col, row, x, y, gridW, gridH, imageScale, alpha );
    }
    // this is mainly for if you want to alpha out part of an image
    // still uses image shader.
    public inline function drawImageTriangleGradient( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                    ,  au: Float, av: Float, bu: Float, bv: Float, cu: Float, cv: Float
                                    , img: Image, colorA: Color, colorB: Color, colorC: Color, alpha: Float = 1. ){
        if( imgLast != img ) flush(); // || shaderMode == GradientMode ) flush();  No longer protection against wrong shaderMode.
        if( alpha != 1. ){
            colorA.A = alpha;
            colorB.A = alpha;
            colorC.A = alpha;
        }
        imgLast = img; 
        var pos = posImage;
        verticesImg.set( pos, ax );
        verticesImg.set( pos +  1, ay );
        verticesImg.set( pos +  2, -5.0 );
        verticesImg.set( pos +  3, au );
        verticesImg.set( pos +  4, av );
        verticesImg.set( pos +  5, colorA.R );
        verticesImg.set( pos +  6, colorA.G );
        verticesImg.set( pos +  7, colorA.B );
        verticesImg.set( pos +  8, colorA.A );
        verticesImg.set( pos +  9, bx );
        verticesImg.set( pos +  10, by );
        verticesImg.set( pos +  11, -5.0 );
        verticesImg.set( pos +  12, bu );
        verticesImg.set( pos +  13, bv );
        verticesImg.set( pos +  14, colorB.R );
        verticesImg.set( pos +  15, colorB.G );
        verticesImg.set( pos +  16, colorB.B );
        verticesImg.set( pos +  17, colorB.A );
        verticesImg.set( pos +  18, cx );
        verticesImg.set( pos +  19, cy );
        verticesImg.set( pos +  20, -5.0 );
        verticesImg.set( pos +  21, cu );
        verticesImg.set( pos +  22, cv );
        verticesImg.set( pos +  23, colorC.R );
        verticesImg.set( pos +  24, colorC.G );
        verticesImg.set( pos +  25, colorC.B );
        verticesImg.set( pos +  26, colorC.A );
        posImage = pos + 27;
        imgBufferIndex++;
    }
    
    public var g4( get, null ): kha.graphics4.Graphics;
    public inline function get_g4(): kha.graphics4.Graphics {
        return ( c != null )? c.g4: f.g4;
    }
    
    
    public var framebuffer( null, set ): Framebuffer;
    function set_framebuffer( f_: Framebuffer ): Framebuffer {
        g               = f_.g4;
        c               = null;
        f               = f_;
        isFramebuffer   = true;
        shaderMode      = ImageMode;
        width           = f.width;
        height          = f.height;
        return f;
    }
    
    public var canvas( null, set ): Canvas;
    function set_canvas( c_: Canvas ): Canvas {
        g               = c_.g4;
        f               = null;
        c               = c_;
        isFramebuffer   = false;
        shaderMode      = GradientMode;
        width           = c.width;
        height          = c.height;
        return c;
    }
    function getProjectionMatrix(): Void {
        if( isFramebuffer ) {
            projectionMatrix = FastMatrix4.orthogonalProjection( 0, width, height, 0, 0.1, 1000 );
        } else {
            if( !Image.nonPow2Supported ) {
                width  = upperPowerOfTwo( width );
                height = upperPowerOfTwo( height );
            }
            if( g.renderTargetsInvertedY() ) {
                projectionMatrix = FastMatrix4.orthogonalProjection( 0, width, 0, height, 0.1, 1000 );
            } else {
                projectionMatrix = FastMatrix4.orthogonalProjection( 0, width, height, 0, 0.1, 1000 );
            }
        }
    }
    function setPipeline( pipeline: PipelineState ): Void {
        this.pipeline = pipeline;
        if( pipeline != null ) g.setPipeline( pipeline );
    }
    function drawBuffer():Void {
        // drawBufferImage();
        // drawBufferGradient();
        if( imgBufferIndex    > 0 ) drawBufferImage();
        if( gradBufferIndex > 0 ) drawBufferGradient();
    }
    function drawBufferGradient():Void{
        vertexBufferGradient.unlock();
        g.setVertexBuffer( vertexBufferGradient );
        g.setIndexBuffer( indexBufferGrad );
        g.setPipeline( gradientPipe );//pipeline == null ? gradientPipe : pipeline);
        g.setMatrix( gradProjMatrix, projectionMatrix );
        g.drawIndexedVertices( 0, gradBufferIndex*3 );
        gradBufferIndex = 0;
        posGradient    = 0;
        verticesGrad    = vertexBufferGradient.lock();
    }
    function drawBufferImage(): Void {
        vertexBufferImage.unlock();
        g.setVertexBuffer( vertexBufferImage );
        g.setIndexBuffer( indexBufferImg );
        g.setPipeline( imagePipe );//pipeline == null ? imagePipe : pipeline);
        g.setTexture( textureLocation, imgLast );
        g.setTextureParameters( textureLocation, textureAddressingX, textureAddressingY, bilinear ? TextureFilter.LinearFilter : TextureFilter.PointFilter, bilinear ? TextureFilter.LinearFilter : TextureFilter.PointFilter, bilinearMipmaps ? MipMapFilter.LinearMipFilter : MipMapFilter.NoMipFilter );
        g.setMatrix( imgProjMatrix, projectionMatrix );
        g.drawIndexedVertices( 0, imgBufferIndex*3 );
        g.setTexture( textureLocation, null );
        imgBufferIndex = 0;
        posImage    = 0;
        verticesImg    = vertexBufferImage.lock();
    }
    public function flush(){
        if( imgBufferIndex  > 0 ) drawBufferImage();
        if( gradBufferIndex > 0 ) drawBufferGradient();
    }
    /*
    a b c
    d e f
    g h i

    a b 0 c
    d e 0 f
    0 0 0 0
    g h 0 i
    */
    public static inline
    function matrix3to4( m: FastMatrix3 ): FastMatrix4 {
        return new FastMatrix4(  m._00,  m._10,  0.,  m._20
                              ,  m._01,  m._11,  0.,  m._21
                              ,     0.,    0.,   1.,     0.
                              ,  m._02,  m._12,  0,   m._22 );
    }
}

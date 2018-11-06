package trilateralXtra.fDrawing;

import nme.display.BitmapData;
import nme.display.Graphics;
import nme.display.TriangleCulling;
import nme.display.Graphics;
import khaMath.Matrix4;
import khaMath.Vector4;
@:enum
abstract ShaderMode( Int ){
    var GradientMode = 0;
    var ImageMode = 1;
}

class PolyPainter {
    public var g: Graphics;
    public var z: Float = 1.;
    var shaderMode = ImageMode;
    var vCount = 0;
    var tCount = 0;
    var iCount = 0;
    var cCount = 0;
    var imgLast: BitmapData = null;
    #if flash
    var _vertices   = new Array<Float>();
    var _tex        = new Array<Float>();
    var _cols       = new Array<Int>();
    var _indices    = new Array<Int>();
    #else
    var _vertices   = new nme.Vector<Float>();// better to fix these to a length?
    var _tex        = new nme.Vector<Float>();
    var _cols       = new nme.Vector<Int>();
    var _indices    = new nme.Vector<Int>();
    #end
    var projectionMatrix: Matrix4;
    public
    function new(){
        projectionMatrix = Matrix4.identity();
    }
    public var graphics( null, set ): Graphics;
    function set_graphics( g_: Graphics ): Graphics {
        g = g_;
        return g;
    }
    public
    function drawImage( img: BitmapData, x: Float = 0, y: Float = 0
                             , w: Null<Float>, h: Null<Float>, alpha: Float = 1. ){
        if( w == null ) w = img.width;
        if( h == null ) h = img.height;
        drawImageTriangle( x, y, x+w, y, x+w, y+h, 0, 0, 1, 0, 1, 1, img, alpha );
        drawImageTriangle( x, y, x+w, y+h, x, y+h, 0, 0, 1, 1, 0, 1, img, alpha );
    }
    public
    function setProjection( projectionMatrix_: Matrix4 ): Void {
        projectionMatrix = projectionMatrix_;
    }
    public
    function drawImageTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                    ,  au: Float, av: Float, bu: Float, bv: Float, cu: Float, cv: Float
                                    , img: BitmapData, alpha: Float = 1.){
        var color = 0xFFFFFFFF;
        drawImageTriangleGradient( ax, ay, bx, by, cx, cy, au, av, bu, bv, cu, cv, img, color, color, color, alpha );
    }
    public
    function begin( shaderMode_: ShaderMode, clear: Bool = true ): Void {
        if( g == null ) return;
        shaderMode = shaderMode_;
        if( clear ) g.clear();
    }
    public
    function changeShaderMode( shaderMode_: ShaderMode ): Void {
        if( shaderMode != shaderMode_ ){
            shaderMode = shaderMode_;
            flush();
        }
    }
    public
    function end(){
        if( g == null ) return;
        flush();
        projectionMatrix = Matrix4.identity();
    }
    public
    function clear( color: Null<Int> = null ): Void {
        if( g == null ) return;
        flush();
        g.clear();
    }
    public inline
    function drawImageGridItem( img: BitmapData, col: Float, row: Float
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
    function drawImageGridIndex( img: BitmapData, id: Int
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, alpha: Float = 1. ){
        var colTot: Float = Math.floor( img.width/gridW );
        var rowTot: Float = Math.floor( img.height/gridH );
        var row: Float = Math.floor( id/colTot );
        var col: Float = id - row*colTot;
        drawImageGridItem( img, col, row, x, y, gridW, gridH, imageScale, alpha );
    }
    public inline
    function drawImageTriangleGradient( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                     ,  au: Float, av: Float, bu: Float, bv: Float, cu: Float, cv: Float
                                     ,  img: BitmapData, colorA: Int, colorB: Int, colorC: Int, alpha: Float = 1. ){
         if( imgLast != img ) flush();
         if( alpha != 1. ) {
             var alphaInt = Math.round(255 * alpha);
             var argb: ARGB;
             argb = colorA;
             argb.alpha = alphaInt;
             colorA = argb;
             argb = colorB;
             argb.alpha = alphaInt;
             colorB = argb;
             argb = colorC;
             argb.alpha = alphaInt;
             colorC = argb;
          }
          var posV = vCount;
          var va = new Vector4( ax, ay, z, 0 );
          var vb = new Vector4( bx, by, z, 0 );
          var vc = new Vector4( cx, cy, z, 0 );
          if( projectionMatrix != null ){
              va = projectionMatrix.multvec( va );
              vb = projectionMatrix.multvec( vb );
              vc = projectionMatrix.multvec( vc );
              _vertices[ posV ]     = va.x;
              _vertices[ posV + 1 ] = va.y;
              _vertices[ posV + 2 ] = vb.x;
              _vertices[ posV + 3 ] = vb.y;
              _vertices[ posV + 4 ] = vc.x;
              _vertices[ posV + 5 ] = vc.y;
         } else {
              _vertices[ posV ]     = ax;
              _vertices[ posV + 1 ] = ay;
              _vertices[ posV + 2 ] = bx;
              _vertices[ posV + 3 ] = by;
              _vertices[ posV + 4 ] = cx;
              _vertices[ posV + 5 ] = cy;
          }
          vCount = posV + 6;
          var posT = tCount;
          _tex[ posT ]          = au;
          _tex[ posT + 1 ]      = av;
          _tex[ posT + 2 ]      = bu;
          _tex[ posT + 3 ]      = bv;
          _tex[ posT + 4 ]      = cu;
          _tex[ posT + 5 ]      = cv;
          tCount = posT + 6;
          var posI = iCount;
          _indices[ posI ] = posI;
          _indices[ posI + 1 ] = posI + 1;
          _indices[ posI + 2 ] = posI + 2;
          iCount = posI + 3;
          var posC = cCount;
          _cols[ posC ] = colorA;
          _cols[ posC + 1 ] = colorB;
          _cols[ posC + 2 ] = colorC;
          cCount = posC + 3;
         imgLast = img;
    }
    public inline
    function drawFillTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                            ,  color: Int, alpha: Float = 1. ){
        drawGradientTriangle( ax, ay, bx, by, cx, cy, color, color, color, alpha );
    }
    public inline 
    function drawGradientTriangle( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float 
                                 , colorA: Int, colorB: Int, colorC: Int, alpha: Float = 1. ){
         if( alpha != 1. ) {
             var alphaInt = Math.round(255 * alpha);
             var argb: ARGB;
             argb = colorA;
             argb.alpha = alphaInt;
             colorA = argb;
             argb = colorB;
             argb.alpha = alphaInt;
             colorB = argb;
             argb = colorC;
             argb.alpha = alphaInt;
             colorC = argb;
          }
          var posV = vCount;
          var va = new Vector4( ax, ay, z, 0 );
          var vb = new Vector4( bx, by, z, 0 );
          var vc = new Vector4( cx, cy, z, 0 );
          if( projectionMatrix != null ){
              va = projectionMatrix.multvec( va );
              vb = projectionMatrix.multvec( vb );
              vc = projectionMatrix.multvec( vc );
              _vertices[ posV ]     = va.x;
              _vertices[ posV + 1 ] = va.y;
              _vertices[ posV + 2 ] = vb.x;
              _vertices[ posV + 3 ] = vb.y;
              _vertices[ posV + 4 ] = vc.x;
              _vertices[ posV + 5 ] = vc.y;
         } else {
              _vertices[ posV ]     = ax;
              _vertices[ posV + 1 ] = ay;
              _vertices[ posV + 2 ] = bx;
              _vertices[ posV + 3 ] = by;
              _vertices[ posV + 4 ] = cx;
              _vertices[ posV + 5 ] = cy;
          }
          vCount = posV + 6;
          var posI = iCount;
          _indices[ posI ] = posI;
          _indices[ posI + 1 ] = posI + 1;
          _indices[ posI + 2 ] = posI + 2;
          iCount = posI + 3;
          var posC = cCount;
          _cols[ posC ] = colorA;
          _cols[ posC + 1 ] = colorB;
          _cols[ posC + 2 ] = colorC;
          cCount = posC + 3;
    }
    inline
    function reset(){
        vCount = 0;
        tCount = 0;
        iCount = 0;
        cCount = 0;
        #if flash
        _vertices   = new Array<Float>();
        _tex        = new Array<Float>();
        _cols       = new Array<Int>();
        _indices    = new Array<Int>();
        #else
        _vertices   = new nme.Vector<Float>();// better to fix these to a length?
        _tex        = new nme.Vector<Float>();
        _cols       = new nme.Vector<Int>();
        _indices    = new nme.Vector<Int>();
        #end
    }
    inline
    function drawBufferImage(){
        g.beginBitmapFill( imgLast );
        g.drawTriangles( _vertices, _indices, _tex, null, _cols );
    }
    inline
    function drawBufferGradient(){
        g.drawTriangles( _vertices, _indices, null, null, _cols );
    }
    inline
    function flush(){
        if( vCount > 0 ) {
            switch( shaderMode ){
                case ImageMode:
                    drawBufferImage();
                case GradientMode:
                    drawBufferGradient();
                }
        }
        reset();
    }
}
abstract ARGB( Int ) from Int to Int {
    inline public function new(argb: Int): ARGB
      this = argb;
    public var red( get, never )  : Int;
    public var green( get, never ): Int;
    public var blue( get, never ) : Int;
    public var alpha( get, set ) : Int;
    inline public static function create( alpha_: Int, red_: Int, green_: Int, blue_: Int ): ARGB
        return ((alpha_ & 0xFF) << 24) | ((red_ & 0xFF) << 16) | ((green_ & 0xFF) << 8) | ((blue_ & 0xFF) << 0);
    inline function set_alpha( alpha_: Int ): Int {
        this = create( alpha_, red, green, blue );
        return alpha_;
    }
    inline function get_alpha(): Int
        return (this >> 24) & 0xFF;
    inline function get_red(): Int
        return (this >> 16) & 0xFF;
    inline function get_green(): Int
        return (this >> 8) & 0xFF;
    inline function get_blue(): Int
        return this & 0xFF;
}

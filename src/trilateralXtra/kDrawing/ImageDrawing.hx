package trilateralXtra.kDrawing;
import kha.Framebuffer;
import kha.Color;
import kha.Image;
import kha.graphics4.TextureAddressing;
import kha.graphics4.DepthStencilFormat;
//import polyPainter.PolyPainter;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import trilateralXtra.kDrawing.PolyPainter;
import hxPolyK.PolyK;
class ImageDrawing {
    public var image:       Image;
    public var count        = 0;
    public var colors       = new Array<Int>();
    public var triangles    = new TriangleArray();
    public var polyPainter:        PolyPainter;
    public
    function new( ?w: Int, ?h: Int ){
        polyPainter                     = new PolyPainter();
        polyPainter.textureAddressingX  = Repeat;
        polyPainter.textureAddressingY  = Repeat;
        if( w != null && h != null ) image = Image.createRenderTarget( w, h, null, DepthStencilFormat.NoDepthAndStencil );
    }
    public 
    function startImage(){
        if( image == null ) return;
        polyPainter.canvas = image;
        polyPainter.begin( true, Color.Transparent );
    }
    public
    function startFrame( framebuffer: Framebuffer ){
        polyPainter.framebuffer = framebuffer;
        polyPainter.begin( true, Color.Transparent );
    }
    public function end() polyPainter.end();
    public // perhaps use matrix instead?
    function renderTriangles( scale: Float, cx: Float, cy: Float ){
        var tri: Triangle;
        //PolyPainter.bufferSize = triangles.length;
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            polyPainter.drawFillTriangle( tri.ax * scale + cx, tri.ay * scale + cy
                                        , tri.bx * scale + cx, tri.by * scale + cy
                                        , tri.cx * scale + cx, tri.cy * scale + cy, colors[ tri.colorID ] );
            
        }
        trace( triangles.length );
    }
    public
    function fill( poly: Array<Float>, colorID: Int ): Void {
        var tgs = PolyK.triangulate( poly ); 
        var triples = new ArrayTriple( tgs );
        for( tri in triples ){
            var a: Int = Std.int( tri.a*2 );
            var b: Int = Std.int( tri.b*2 );
            var c: Int = Std.int( tri.c*2 );
            triangles.drawTriangle(  count, { x: poly[ a ], y: poly[ a + 1 ] }
                                       , { x: poly[ b ], y: poly[ b + 1 ] }
                                       , { x: poly[ c ], y: poly[ c + 1 ] }, colorID );
        }
        trace( triangles.length );
    }
    public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
    public inline
    function colorId( color: Int ): Int {
        var id = colors.indexOf( color );
        if( id == -1 ) {
            id = colors.length;
            colors[ id ] = color;
        }
        return id;
    }
}
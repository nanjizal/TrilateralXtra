package trilateralXtra.kDrawing;
import kha.Framebuffer;
import kha.Color;
import kha.Image;
import kha.graphics4.TextureAddressing;
import kha.graphics4.DepthStencilFormat;
import trilateralXtra.kDrawing.PolyPainter;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import trilateralXtra.kDrawing.PolyPainter;
import trilateral.parsing.FillDraw;
class ImageDrawing {
    public var image:       Image;
    public var fillDraw:    FillDraw;
    public var polyPainter:        PolyPainter;
    public
    function new( ?fillDraw_: FillDraw ){
        fillDraw                        = fillDraw_;
        polyPainter                     = new PolyPainter();
        polyPainter.textureAddressingX  = Repeat;
        polyPainter.textureAddressingY  = Repeat;
        if( fillDraw != null ){
            image = Image.createRenderTarget( fillDraw.width, fillDraw.height, null, DepthStencilFormat.NoDepthAndStencil, 4 );
        }
    }
    public 
    function startImage(){
        if( image == null ) return;
        polyPainter.canvas = image;
        polyPainter.begin( ImageMode, true, Color.Transparent );
    }
    public
    function startFrame( framebuffer: Framebuffer ){
        polyPainter.framebuffer = framebuffer;
        polyPainter.begin( ImageMode, true, Color.Transparent );
    }
    public function end() polyPainter.end();
    public // perhaps use matrix instead?
    function renderTriangles( scale: Float, cx: Float, cy: Float, ?alpha: Float = 1 ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
        var colors      = fillDraw.colors;
        //PolyPainter.bufferSize = triangles.length;
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            polyPainter.drawFillTriangle( tri.ax * scale + cx, tri.ay * scale + cy
                                        , tri.bx * scale + cx, tri.by * scale + cy
                                        , tri.cx * scale + cx, tri.cy * scale + cy, colors[ tri.colorID ], alpha );
            
        }
        //trace( triangles.length );
    }
    public // perhaps use matrix instead?
    function renderGradientTriangles( scale: Float, cx: Float, cy: Float, ?alpha: Float = 1 ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
        var colors      = fillDraw.colors;
        //PolyPainter.bufferSize = triangles.length;
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            polyPainter.drawGradientTriangle( tri.ax * scale + cx, tri.ay * scale + cy
                                        , tri.bx * scale + cx, tri.by * scale + cy
                                        , tri.cx * scale + cx, tri.cy * scale + cy
                                        , colors[ tri.colorA ], colors[ tri.colorB ], colors[ tri.colorC ], alpha );
            
        }
        //trace( triangles.length );
    }
    public // perhaps use matrix instead?
    function renderImageTriangles( img: Image, scale: Float, dx: Float, dy: Float, ?alpha: Float = 1. ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
        var colors      = fillDraw.colors;
        //PolyPainter.bufferSize = triangles.length;
        var img1W = 1/img.width;
        var img1H = 1/img.height;
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            var ax = tri.ax * scale + dx;
            var ay = tri.ay * scale + dy;
            var bx = tri.bx * scale + dx;
            var by = tri.by * scale + dy;
            var cx = tri.cx * scale + dx;
            var cy = tri.cy * scale + dy;
            var au = ax*img1W;
            var av = ay*img1H;
            var bu = bx*img1W;
            var bv = by*img1H;
            var cu = cx*img1W;
            var cv = cy*img1H;
            polyPainter.drawImageTriangle( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, alpha );
        }
        //trace( triangles.length );
    }
    public // perhaps use matrix instead?
    function renderImageTrianglesOffset( img: Image, scale: Float, dx: Float, dy: Float, ex: Float, ey: Float, ?alpha: Float = 1. ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
        var colors      = fillDraw.colors;
        //PolyPainter.bufferSize = triangles.length;
        var img1W = 1/img.width;
        var img1H = 1/img.height;
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            var ax = tri.ax * scale + dx;
            var ay = tri.ay * scale + dy;
            var bx = tri.bx * scale + dx;
            var by = tri.by * scale + dy;
            var cx = tri.cx * scale + dx;
            var cy = tri.cy * scale + dy;
            var au = ( ax + ex )*img1W;
            var av = ( ay + ey )*img1H;
            var bu = ( bx + ex )*img1W;
            var bv = ( by + ey )*img1H;
            var cu = ( cx + ex )*img1W;
            var cv = ( cy + ey )*img1H;
            polyPainter.drawImageTriangle( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, alpha );
        }
        //trace( triangles.length );
    }
}
}

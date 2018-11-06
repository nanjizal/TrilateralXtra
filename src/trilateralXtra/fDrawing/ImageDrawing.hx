package trilateralXtra.fDrawing;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.display.Graphics;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import trilateralXtra.fDrawing.PolyPainter;
import trilateral.parsing.FillDraw;
class ImageDrawing {
    public var image:              Sprite; // DisplayObject not working here!
    public var fillDraw:           FillDraw;
    public var polyPainter:        PolyPainter;
    public
    function new( ?fillDraw_: FillDraw ){
        fillDraw                        = fillDraw_;
        polyPainter                     = new PolyPainter();
        if( fillDraw != null ){
            image = new Sprite();
        }
    }
    public 
    function startImage(){
        if( image == null ) return;
        polyPainter.graphics = image.graphics;
        polyPainter.begin( ImageMode, true );
    }
    public
    function startFrame( framebuffer: Sprite ){
        polyPainter.graphics = framebuffer.graphics;
        polyPainter.begin( ImageMode, true );
    }
    public function end() polyPainter.end();
    public // perhaps use matrix instead?
    function renderTriangles( scale: Float, cx: Float, cy: Float, alpha: Float = 1 ){
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
    function renderGradientTriangles( scale: Float, cx: Float, cy: Float, alpha: Float = 1 ){
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
    public inline
    function drawImageGridIndexColor( img: BitmapData, id: Int
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, color: Int = 0xFFFFFFFF, alpha: Float = 1. ){
        polyPainter.drawImageGridIndexColor( img, id, x, y, gridW, gridH, imageScale, color, alpha );
    }
    public inline
    function drawImageGridItemColor( img: BitmapData, col: Float, row: Float
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, color: Int = 0xFFFFFFFF, alpha: Float = 1. ){
        polyPainter.drawImageGridItemColor( img, col, row, x, y, gridW, gridH, imageScale, color, alpha );
    }
    
    public inline
    function drawImageGridIndex( img: BitmapData, id: Int
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, alpha: Float = 1. ){
        polyPainter.drawImageGridIndex( img, id, x, y, gridW, gridH, imageScale, alpha );
    }
    public inline
    function drawImageGridItem( img: BitmapData, col: Float, row: Float
                              , x: Float, y: Float, gridW: Float, gridH: Float
                              ,  imageScale: Float, alpha: Float = 1. ){
        polyPainter.drawImageGridItem( img, col, row, x, y, gridW, gridH, imageScale, alpha );
    }
    public // perhaps use matrix instead?
    function renderImageTriangles( img: BitmapData, scale: Float, dx: Float, dy: Float, alpha: Float = 1. ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
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
    public
    function renderImageTrianglesOffset( img: BitmapData, canvasScale: Float, imageScale: Float, dx: Float, dy: Float, alpha: Float = 1. ){
        var tri: Triangle;
        var triangles   = fillDraw.triangles;
        var scale       = 1/imageScale;
        var img1W = 1/(img.width);
        var img1H = 1/(img.height);
        for( i in 0...Std.int( triangles.length ) ){
            tri = triangles[ i ];
            var ax = canvasScale*( tri.ax + dx );
            var ay = canvasScale*( tri.ay + dy );
            var bx = canvasScale*( tri.bx + dx );
            var by = canvasScale*( tri.by + dy );
            var cx = canvasScale*( tri.cx + dx );
            var cy = canvasScale*( tri.cy + dy );
            var au = ( tri.ax * scale )*img1W;
            var av = ( tri.ay * scale )*img1H;
            var bu = ( tri.bx * scale )*img1W;
            var bv = ( tri.by * scale )*img1H;
            var cu = ( tri.cx * scale )*img1W;
            var cv = ( tri.cy * scale )*img1H;
            polyPainter.drawImageTriangle( ax, ay, bx, by, cx, cy,  au, av, bu, bv, cu, cv, img, alpha );
        }
        //trace( triangles.length );
    }
}

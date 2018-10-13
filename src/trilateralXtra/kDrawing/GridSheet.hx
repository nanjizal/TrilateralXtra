package gridSheet;
import kha.Image;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
typedef GridSheetDef = {
    var gridX:      Float;
    var gridY:      Float;
    var totalRows:  Int;
    var totalCols:  Int;
    var scaleX:     Float;
    var scaleY:     Float;
    var image:      Image;
}
typedef GridItemDef = {
    var x: Float;
    var y: Float;
    var alpha: Float;
    var transform: FastMatrix3;
}
typedef GridItems = {
    function getItem( row: Float, col: Float ): GridItemDef;
}
// SpriteSheet
class GridSheet{
    // used to allow offset of rectangles
    public var dx = 0.; 
    public var dy = 0.;
    var gridX:      Float;
    var gridY:      Float;
    var scaleX:     Float;
    var scaleY:     Float;
    var totalRows:  Int;
    var totalCols:  Int;
    var r:          Int = 0;
    var c:          Int = 0;
    var count:      Int = 0;
    var image:      Image;
    public var totalCount: Float = 8; // relates to render speed.
    public function calculateRows(){
        return Math.round( image.width/gridX );
    }
    public function calculateCols(){
        return Math.round( image.height/gridY );
    }
    
    public function new( gi: GridSheetDef ){
        gridX       = gi.gridX;
        gridY       = gi.gridY;
        totalRows   = gi.totalRows;
        totalCols   = gi.totalCols;
        scaleX      = gi.scaleX;
        scaleY      = gi.scaleY;
        image       = gi.image;
    }
    public function renderGrid( g: Graphics, gridItems: GridItems ){
        var p: { x: Float, y: Float };
        var alpha: Float;
        for( col in 0...totalCols ){
            for( row in 0...totalRows ){
                renderFrame( g, gridItems, row, col );
            }
        }
        // assume to reset it to 1.
        g.transformation = FastMatrix3.identity();
        g.opacity = 1.;
    }
    public function renderSequence( g: Graphics, gridItems: GridItems ){
        renderFrame( g, gridItems, r, c );
        advanceFrame();
    }
    inline function renderFrame( g: Graphics, gridItems: GridItems, row: Int, col: Int ){
        var item = gridItems.getItem( row, col );
        g.opacity = item.alpha;
        g.transformation = item.transform;
        g.drawScaledSubImage( image
                            , row*gridX + dx, col*gridY + dy
                            , gridX, gridY
                            , item.x, item.y
                            , gridX * scaleX, gridY * scaleY );
    }
    inline function advanceFrame(){
        if( count == totalCount ){
            count = 0;
            r++;
            if( r > totalRows - 1 ){
                r = 0;
                c++;
                if( c > totalCols - 1 ){
                    c = 0;
                }
            }
        }
        count++;
    }
    // default one to give a grid layout.
    inline function getItem( row: Int, col: Int ): GridItemDef {
        return { x: scaleX*row*gridX, y: scaleY*col*gridY, alpha: 1., transform: FastMatrix3.identity() };
    }
}
class SequenceSprite{
    public var x: Float = 0;
    public var y: Float = 0;
    public var alpha: Float = 0;
    public var matrix: FastMatrix3;
    public function new( x_: Float, y_: Float, alpha_: Float, matrix_: FastMatrix3 ){
        x = x_;
        y = y_;
        alpha = alpha_;
        matrix = matrix_;
    }
    inline function getItem( row: Int, col: Int ): GridItemDef {
        return { x: x, y: y, alpha: alpha, transform: matrix };
    }
}

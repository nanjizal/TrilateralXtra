package trilateralXtra.kDrawing;
import kha.Image;
import kha.Color;
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
    var x:      Float;
    var y:      Float;
    var alpha:  Float;
    var color:  Color;
    var transform: FastMatrix3;
    var depth:  Int;
}
typedef ItemAtt = {
    var item: GridItemDef;
    var col: Int;
    var row: Int;
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
    public function renderGrid( g: Graphics, gridItems: GridItems, ?outline: Bool = false ){
        var p: { x: Float, y: Float };
        var alpha: Float;
        var item: GridItemDef;
        var temp: Array<ItemAtt> = [];
        var count = 0;
        for( row in 0...totalRows ){
            for( col in 0...totalCols ){
                item = gridItems.getItem( col, row );
                temp[ count++ ] = { item: item, col: col, row: row };
            }
        }
        depthSort( temp );
        var obj: ItemAtt;
        for( i in 0...temp.length ){
            obj = temp[ i ];
            renderItem( g, obj.item, obj.col, obj.row, outline );
        }
        resetGraphics( g );
    }
    inline function resetGraphics( g: Graphics ){
        g.color = Color.White;
        g.transformation = FastMatrix3.identity(); 
        g.opacity = 1.;
    }
    inline function depthSort( arr: Array<ItemAtt> ){
        haxe.ds.ArraySort.sort( arr, function( a, b ): Int {
            var c = a.item.depth;
            var d = b.item.depth;
            if( c < d ){
                return -1;
            } else if ( c > d ){ 
                return 1;
            } else {
                return 0;
            }
        });
    } 
    public function renderSequence( g: Graphics, gridItems: GridItems ){
        renderFrame( g, gridItems, c, r );
        advanceFrame();
    }
    inline function renderItem( g: Graphics, item: GridItemDef, col: Int, row: Int, ?outline: Bool = false ){
        g.opacity = item.alpha;
        g.transformation = item.transform;
        if( outline ){
            g.color = Color.Red;
            g.drawRect( item.x, item.y, gridX, gridY, 1 );
            g.color = item.color;
        }
        g.color = item.color;
        g.drawScaledSubImage( image
                            , col*gridX + dx, row*gridY + dy
                            , gridX, gridY
                            , item.x, item.y
                            , gridX * scaleX, gridY * scaleY );
        g.color = Color.White;
    }
    
    inline function renderFrame( g: Graphics, gridItems: GridItems, col: Int, row: Int, ?outline: Bool = false ){
        var item = gridItems.getItem( col, row );
        g.opacity = item.alpha;
        g.transformation = item.transform;
        if( outline ){
            g.color = Color.Red;
            g.drawRect( item.x, item.y, gridX, gridY, 1 );
            g.color = item.color;
        }
        g.color = item.color;
        g.drawScaledSubImage( image
                            , col*gridX + dx, row*gridY + dy
                            , gridX, gridY
                            , item.x, item.y
                            , gridX * scaleX, gridY * scaleY );
        g.color = Color.White;
    }
    inline function advanceFrame(){
        if( count == totalCount ){
            count = 0;
            c++;
            if( c > totalCols - 1 ){
                c = 0;
                r++;
                if( r > totalRows - 1 ){
                    r = 0;
                }
            }
        }
        count++;
    }
    // default one to give a grid layout.
    inline function getItem( col: Int, row: Int ): GridItemDef {
        return { x:         scaleX*col*gridX
               , y:         scaleY*row*gridY
               , color:     Color.White
               , alpha:     1.
               , transform: FastMatrix3.identity()
               , depth: 0
           };
    }
}
class SequenceSprite{
    public var x: Float = 0;
    public var y: Float = 0;
    public var color: Color = Color.White;
    public var alpha: Float = 0;
    public var matrix: FastMatrix3;
    public var depth: Int = 0;
    public function new( x_: Float, y_: Float, color_: Color, alpha_: Float, matrix_: FastMatrix3, depth_: Int ){
        x = x_;
        y = y_;
        color = color_;
        alpha = alpha_;
        matrix = matrix_;
        depth = depth_;
    }
    inline function getItem( col: Int, row: Int ): GridItemDef {
        return { x: x, y: y, color: color, alpha: alpha, transform: matrix, depth: depth };
    }
}

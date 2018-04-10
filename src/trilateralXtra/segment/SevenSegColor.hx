package trilateralXtra.segment;
import trilateral.tri.Trilateral;
import trilateral.tri.Triangle;
import trilateral.tri.TriangleArray;
import trilateral.tri.TrilateralArray;
// Used to emulate 7 segment display, can be used for rough letters.
class SevenSegColor{
    public var lightID: Int; // ColorID of segment on say the id of Red
    public var darkID:  Int; // ColorID of segment off say the id of black
    public var width:   Float = 0.10;
    public var height:  Float = 0.18;
    public var unit:    Float   = 0.01;
    public var x:       Float;
    public var y:       Float;
    public var gap:     Float;
    public var spacing: Float;
    public var triArr:  TriangleArray;
    public var digitID: Int = 0;
    public var startID: Int;
    public var endID: Int;
    public function new( width_: Float, height_: Float, lightID_: Int, darkID_: Int, ?triangleArray_: TriangleArray = null ){
        height  = height_;
        width   = width_;
        lightID = lightID_;
        darkID  = darkID_;
        unit    = width_ * (1/10);
        gap     = unit/5;
        spacing = width + unit*1.5;
        triArr  = ( triangleArray_ == null )? new Array<Triangle>(): triangleArray_;
        startID = triArr.length;
    } 
    public inline 
    function numberWidth( val: Int ): Float {
        var str = Std.string( val );
        return stringWidth( str );
    }
    public inline
    function stringWidth( str: String ): Float {
        var l = str.length;
        var space = 0.;
        for( i in 0...l ){
            space += spacing;
        }
        return space;
    }
    public inline
    function addNumber( val: Int, x_: Float, y_: Float, ?centre: Bool = false ){
        var str = Std.string( val );
        addString( str, x_, y_, centre );
    }
    public inline
    function addString( str: String, x_: Float, y_: Float, ?centre: Bool = false ){
        var l = str.length;
        var space = 0.;
        if( centre ){
            for( i in 0...l ){
                space += spacing;
            }
            space -= unit*1.5;// centreX makes assumption for simplicity see spacing in constructor.
            space = -space/2;
            y_ = y_ - height/2;
        }
        for( i in 0...l ){
            addDigit( Std.parseInt( str.substr( i, 1 ) ), x_ + space, y_ );
            space += spacing;
        }
    }
    public function color( id: Int, color: Int ){
        triArr.changeFillColorByID( id, color, startID, endID );
    }
    // Assumes from 0
    public inline function changeString( str: String ){
        var l = str.length;
        for( i in 0...l ){
            changeDigit( Std.parseInt( str.substr( i, 1 ) ), i );
        }
    }
    public inline function changeNumber( val: Int ){
        var str = Std.string( val );
        changeString( str );
    }
    public inline function changeDigit( hexCode: Int, digit: Int ){
        var id = startID + Std.int( digit*7 );
        switch( hexCode ){
            case 0:
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, darkID  );
            case 1:
                color( id, darkID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, darkID );
                color( id + 4, darkID );
                color( id + 5, darkID );
                color( id + 6, darkID );
            case 2:
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, darkID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, darkID );
                color( id + 6, lightID );
            case 3:
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, darkID );
                color( id + 5, darkID );
                color( id + 6, lightID );
            case 4:
                color( id, darkID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, darkID );
                color( id + 4, darkID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 5:
                color( id, lightID );
                color( id + 1, darkID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, darkID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 6:
                color( id, lightID );
                color( id + 1, darkID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 7:
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, darkID );
                color( id + 4, darkID );
                color( id + 5, darkID );
                color( id + 6, darkID );
            case 8:
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 9: 
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, darkID );
                color( id + 4, darkID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 10: // A
                color( id, lightID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, darkID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 11: // b
                color( id, darkID );
                color( id + 1, darkID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 12: // C
                color( id, lightID );
                color( id + 1, darkID );
                color( id + 2, darkID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, darkID );
            case 13: // d
                color( id, darkID );
                color( id + 1, lightID );
                color( id + 2, lightID );
                color( id + 3, lightID );
                color( id + 4, lightID );
                color( id + 5, darkID );
                color( id + 6, lightID );
            case 14: // E
                color( id, lightID );
                color( id + 1, darkID );
                color( id + 2, darkID );
                color( id + 3 , lightID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
            case 15: // F
                color( id, lightID );
                color( id + 1, darkID );
                color( id + 2, darkID );
                color( id + 3, darkID );
                color( id + 4, lightID );
                color( id + 5, lightID );
                color( id + 6, lightID );
        }
    }
    public inline function addDigit( hexCode: Int, x_: Float, y_: Float ){
        var id = startID + digitID;
        x = x_;
        y = y_;
        switch( hexCode ){
            case 0:
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, darkID  );
            case 1:
                a( id, darkID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, darkID );
                e( id + 4, darkID );
                f( id + 5, darkID );
                g( id + 6, darkID );
            case 2:
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, darkID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, darkID );
                g( id + 6, lightID );
            case 3:
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, darkID );
                f( id + 5, darkID );
                g( id + 6, lightID );
            case 4:
                a( id, darkID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, darkID );
                e( id + 4, darkID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 5:
                a( id, lightID );
                b( id + 1, darkID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, darkID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 6:
                a( id, lightID );
                b( id + 1, darkID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 7:
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, darkID );
                e( id + 4, darkID );
                f( id + 5, darkID );
                g( id + 6, darkID );
            case 8:
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 9: 
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, darkID );
                e( id + 4, darkID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 10: // A
                a( id, lightID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, darkID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 11: // b
                a( id, darkID );
                b( id + 1, darkID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 12: // C
                a( id, lightID );
                b( id + 1, darkID );
                c( id + 2, darkID );
                e( id + 3, lightID );
                d( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, darkID );
            case 13: // d
                a( id, darkID );
                b( id + 1, lightID );
                c( id + 2, lightID );
                d( id + 3, lightID );
                e( id + 4, lightID );
                f( id + 5, darkID );
                g( id + 6, lightID );
            case 14: // E
                a( id, lightID );
                b( id + 1, darkID );
                c( id + 2, darkID );
                d( id + 3 , lightID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
            case 15: // F
                a( id, lightID );
                b( id + 1, darkID );
                c( id + 2, darkID );
                d( id + 3, darkID );
                e( id + 4, lightID );
                f( id + 5, lightID );
                g( id + 6, lightID );
        }
        digitID += 7;
        endID = triArr.length;
    }
    inline
    function a( id: Int, color: Int ){
        horiSeg( id, x, y, color );
    }
    inline
    function b( id: Int, color: Int ){
        vertSeg( id, x + width - 2*unit, y, color );
    }
    inline
    function c( id: Int, color: Int ){
        var hi = height/2;
        vertSeg( id, x + width - 2*unit, y + hi - unit, color );
    }
    inline
    function d( id: Int, color: Int ){
        horiSeg( id, x, y + height - 2*unit, color );
    }
    inline
    function e( id: Int, color: Int ){
        var hi = height/2;
        vertSeg( id, x, y + hi - unit, color );
    }
    inline
    function f( id: Int, color: Int ){
        vertSeg( id, x, y, color );
    }
    inline
    function g( id: Int, color: Int ){
        var hi = height/2;
        horiSeg( id, x, y + hi - unit, color );
    }
    inline
    function dp(){
        // not implemented
    }
    inline
    function triFactory( id: Int, ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float, colorID: Int ): Triangle {
        return Triangle.fromTrilateral( id
                                    ,   new Trilateral( ax, ay, bx, by, cx, cy )
                                    ,   0
                                    ,   colorID );
    }
    inline
    function horiSeg( id: Int, x_: Float, y_: Float, colorID: Int ){
        var tri = triArr;
        var l = tri.length;
        tri[ l ] = triFactory( id, x_ + unit + gap, y_ + unit, x_ + 2*unit, y_, x_ + width - unit - gap, y_ + unit, colorID );
        l++;
        tri[ l ] = triFactory( id, x_ + 2*unit, y_, x_ + width - 2*unit, y_, x_ + width - unit - gap, y_ + unit, colorID );
        l++;
        tri[ l ] = triFactory( id, x_ + unit + gap, y_ + unit, x_ + width - unit - gap, y_  + unit, x_ + width - 2*unit, y_ + 2*unit, colorID );
        l++;
        tri[ l ] = triFactory( id, x_ + unit + gap, y_ + unit, x_ + width - 2*unit, y_  + 2*unit, x_ + 2*unit, y_ + 2*unit, colorID );
    }
    inline
    function vertSeg( id: Int, x_: Float, y_: Float, colorID: Int ){
        var tri = triArr;
        var l = tri.length;
        var hi = height/2;
        tri[ l ] = triFactory( id, x_, y_ + 2*unit, x_ + unit, y_ + hi - gap, x_, y_ + hi - unit + gap, colorID );
        l++;
        tri[ l ] = triFactory( id, x_, y_ + 2*unit, x_ + unit, y_ + unit + gap, x_ + unit, y_ + hi - gap, colorID );
        l++;
        tri[ l ] = triFactory( id, x_ + unit, y_ + unit + gap, x_ + 2*unit, y_  + hi - unit, x_ + unit, y_ + hi - gap, colorID );
        l++;
        tri[ l ] = triFactory( id, x_ + unit, y_ + unit + gap, x_ + 2*unit, y_  + 2*unit, x_ + 2*unit, y_ + hi - unit, colorID );
    }
}
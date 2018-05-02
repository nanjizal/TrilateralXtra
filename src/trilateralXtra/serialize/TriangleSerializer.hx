package trilateralXtra.serialize;
import trilateral.tri.Triangle;
import trilateral.tri.TriangleArray;
import trilateral.tri.Trilateral;
import hxbit.Serializable;

@:enum abstract Store(Int) from Int to Int{
    var ID          = 1 << 0;
    var MARK        = 1 << 1;
    var ALPHA       = 1 << 2;
    var COLOR_ID    = 1 << 3;
    var COLOR_A     = 1 << 4;
    var COLOR_B     = 1 << 5;
    var COLOR_C     = 1 << 6;
    var DEPTH       = 1 << 7;
}

class TriangleSerializer implements hxbit.Serializable {
    public var optionLengthBit:  Int = 0;
    public var triangle:         Triangle;
    public var lastTriangle:     Triangle = null;
    
    // store parmeters on triangle prior to reconstruction.
    var tempAX: Float;
    var tempBX: Float;
    var tempCX: Float;
    var tempAY: Float;
    var tempBY: Float;
    var tempCY: Float;

    @:s public var ax( get, set ): Float;
    function get_ax(): Float {
        return triangle.ax;
    }
    function set_ax( val: Float ): Float {
        tempAX = val;
        return val;
    }
    
    @:s public var bx( get, set ): Float;
    function get_bx(): Float {
        return triangle.bx;
    }
    function set_bx( val: Float ): Float {
        tempBX = val;
        return val;
    }
    
    @:s public var cx( get, set ): Float;
    function get_cx(): Float {
        return triangle.cx;
    }
    function set_cx( val: Float ): Float {
        tempCX = val;
        return val;
    }
    
    @:s public var ay( get, set ): Float;
    function get_ay(): Float {
        return triangle.ay;
    }
    function set_ay( val: Float ): Float {
        tempAY = val;
        return val;
    }
    
    @:s public var by( get, set ): Float;
    function get_by(): Float {
        return triangle.by;
    }
    function set_by( val: Float ): Float {
        tempBY = val;
        return val;
    }
    
    @:s public var cy( get, set ): Float;
    function get_cy(): Float {
        return triangle.cy;
    }
    function set_cy( val: Float ): Float {
        tempCY = val;
        return val;
    }
    
    public function new( ?triangle_: Triangle ){
        if( triangle_ != null ) triangle = triangle_;
    }
    @:keep
    public function customSerialize( ctx : hxbit.Serializer ){
        optionLengthBit = 0;
        /*
        // only store id if not same as last.
        var needsID         = ( lastTriangle == null )? true: 
                                    ( if( triangle.id != lastTriangle.id )? true: false );
        */
        // for Simplicity at moment assume to store id's for all Triangles.
        var needsID          = true;
        var needsMark       = ( triangle.mark != 0 );
        var needsAlpha      = ( triangle.alpha   != 1. );
        var needsColorID    = ( triangle.colorID != 0xFF000000 );
        var noColorA        = ( triangle.colorA == null );
        var colorSame       = ( noColorA )? ( triangle.colorID == triangle.colorA && triangle.colorID == triangle.colorB && triangle.colorID == triangle.colorC ): true;
        var needsDepth      = ( triangle.depth == null );
        if( needsID )       add( ID );
        if( needsMark )     add( MARK );
        if( needsAlpha )    add( ALPHA );
        if( needsColorID )  add( COLOR_ID );
        if( !colorSame ){
            add( COLOR_A );
            add( COLOR_B );
            add( COLOR_C );
        }
        if( needsDepth ) add( DEPTH );
        // store optional properties that need adding.
        ctx.addInt( optionLengthBit );
        if( needsID )         ctx.addInt(   triangle.id );
        if( needsMark )       ctx.addInt(   triangle.mark );
        if( needsAlpha )      ctx.addFloat( triangle.alpha );
        if( needsColorID )    ctx.addInt(   triangle.colorID );
        if( !colorSame ){
                              ctx.addInt( triangle.colorA );
                              ctx.addInt( triangle.colorB );
                              ctx.addInt( triangle.colorC );
        }
        if( needsDepth )  ctx.addFloat( triangle.depth );
        
    }
    inline public function add( mask: Int ){
            optionLengthBit = optionLengthBit | mask;
    }
    inline public static function contains( bits :Int, mask :Int ): Bool {
            return bits & mask != 0;
    }
    @:keep
    public function customUnserialize( ctx : hxbit.Serializer ){
        optionLengthBit = ctx.getInt();
        var id = 0;
        //if( optionLengthBit == 0 ) return;
        if( contains( optionLengthBit, ID ) )       id               = ctx.getInt();
        var trilateral = new Trilateral( tempAX, tempAY, tempBX, tempBY, tempCX, tempCY );
        triangle = Triangle.fromTrilateral( id, trilateral, 0, 0 );
        /*triangle = new Triangle( id, { x: tempAX, y: tempAY }
                                   , { x: tempBX, y: tempBY }
                                   , { x: tempCX, y: tempCY }, 0, 0 );*/
        if( contains( optionLengthBit, MARK ) )     triangle.mark    = ctx.getInt();
        if( contains( optionLengthBit, ALPHA ) )    triangle.alpha   = ctx.getFloat();
        if( contains( optionLengthBit, COLOR_ID ) ) triangle.colorID = ctx.getInt();
        if( contains( optionLengthBit, COLOR_A ) )  triangle.colorA  = ctx.getInt();
        if( contains( optionLengthBit, COLOR_B ) )  triangle.colorB  = ctx.getInt();
        if( contains( optionLengthBit, COLOR_C ) )  triangle.colorC  = ctx.getInt();
        if( contains( optionLengthBit, DEPTH ) )    triangle.depth   = ctx.getFloat();
    }
}
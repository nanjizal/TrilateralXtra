package trilateralXtra.serialize;
import trilateral.tri.Trilateral;
import trilateral.tri.TrilateralArray;
import hxbit.Serializable;

class TrilateralSerializer implements hxbit.Serializable {
    public var trilateral:       Trilateral;
    
    // don't bother storing 'mark' as it's mostly used for debug.
    
    // store parmeters on triangle prior to reconstruction.
    var tempAX: Float;
    var tempBX: Float;
    var tempCX: Float;
    var tempAY: Float;
    var tempBY: Float;
    var tempCY: Float;

    @:s public var ax( get, set ): Float;
    function get_ax(): Float {
        return trilateral.ax;
    }
    function set_ax( val: Float ): Float {
        tempAX = val;
        return val;
    }
    
    @:s public var bx( get, set ): Float;
    function get_bx(): Float {
        return trilateral.bx;
    }
    function set_bx( val: Float ): Float {
        tempBX = val;
        return val;
    }
    
    @:s public var cx( get, set ): Float;
    function get_cx(): Float {
        return trilateral.cx;
    }
    function set_cx( val: Float ): Float {
        tempCX = val;
        return val;
    }
    
    @:s public var ay( get, set ): Float;
    function get_ay(): Float {
        return trilateral.ay;
    }
    function set_ay( val: Float ): Float {
        tempAY = val;
        return val;
    }
    
    @:s public var by( get, set ): Float;
    function get_by(): Float {
        return trilateral.by;
    }
    function set_by( val: Float ): Float {
        tempBY = val;
        return val;
    }
    
    @:s public var cy: Float;
    function get_cy(): Float {
        return trilateral.cy;
    }
    function set_cy( val: Float ): Float {
        tempCY = val;
        return val;
    }
    
    public function new( ?trilateral_: Trilateral ){
        if( trilateral != null ) trilateral = trilateral_;
    }
    @:keep
    public function customSerialize( ctx : hxbit.Serializer ){
        
    }
    @:keep
    public function customUnserialize( ctx : hxbit.Serializer ){
        trilateral = new Trilateral( tempAX, tempAY, tempBX, tempBY, tempCX, tempCY );
    }
}
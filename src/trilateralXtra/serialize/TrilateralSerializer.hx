package trilateralXtra;
import trilateral.tri.Trilateral;
import trilateral.tri.TrilateralArray;
import hxbit.Serializable;

class TriangleSerializer implements hxbit.Serializable {
    public var trilateral:       Trilateral;
    
    // don't bother storing 'mark' as it's mostly used for debug.
    
    // store parmeters on triangle prior to reconstruction.
    var tempAX: Float;
    var tempBX: Float;
    var tempCX: Float;
    var tempAY: Float;
    var tempBY: Float;
    var tempCY: Float;

    s:@ public var ax( get, set ): Float;
    function get_ax(): Float {
        return triangle.ax;
    }
    function set_ax( val: Float ): Float {
        tempAX = val;
        return val;
    }
    
    s:@ public var bx( get, set ): Float;
    function get_bx(): Float {
        return triangle.bx;
    }
    function set_bx( val: Float ): Float {
        tempBX = val;
        return val;
    }
    
    s:@ public var cx( get, set ): Float;
    function get_cx(): Float {
        return triangle.cx;
    }
    function set_cx( val: Float ): Float {
        tempCX = val;
        return val;
    }
    
    s:@ public var ay( get, set ): Float;
    function get_ay(): Float {
        return triangle.ay;
    }
    function set_ay( val: Float ): Float {
        tempAY = val;
        return val;
    }
    
    s:@ public var by( get, set ): Float;
    function get_by(): Float {
        return triangle.by;
    }
    function set_by( val: Float ): Float {
        tempBY = val;
        return val;
    }
    
    s:@ public var cy: Float;
    function get_cy(): Float {
        return triangle.cy;
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
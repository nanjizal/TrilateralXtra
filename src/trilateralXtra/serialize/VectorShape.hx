package trilateralXtra.serialize;
import trilateral.tri.Trilateral;
import trilateral.tri.TrilateralArray;
//import trilateralXtra.serialize.TrilateralSerializer;
import hxbit.Serializable;

class VectorShape implements hxbit.Serializable {
    @:s public var trilateralSerializeArr: Array<TrilateralSerializer>;
    public function new( triArr: TrilateralArray ){
        // store triangles in in serializable structure.
        trilateralSerializeArr = toSerializeArray( triArr );
    }
    public function getTrilateralArray():TrilateralArray {
        return toTrilateralArray( trilateralSerializeArr );
    }
    static function toSerializeArray( triArr: TrilateralArray ): Array<TrilateralSerializer> {
        var arr: Array<TrilateralSerializer> = [];
        for( i in 0...triArr.length ) arr[ i ] = new TrilateralSerializer( triArr[ i ] );
        return arr;
    }
    static function toTrilateralArray( arrSerializer: Array<TrilateralSerializer>, ?clear: Bool = false ): TrilateralArray {
        var arr = new TrilateralArray();
        for( i in 0...arr.length ) {
            arr[ i ] = arrSerializer[ i ].trilateral;
            if( clear ) arrSerializer[ i ] = null; // destroy.
        }
        if( clear ) arrSerializer = null;
        return arr;
    }
}
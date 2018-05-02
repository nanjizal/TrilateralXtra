package trilateralXtra.serialize;
import trilateral.tri.Triangle;
import trilateral.tri.TriangleArray;
import trilateralXtra.serialize.TriangleSerializer;
import hxbit.Serializable;

class VectorImage implements hxbit.Serializable {
    @:s public var colors: Array<Int>;
    @:s public var triSerializeArr: Array<TriangleSerializer>;
    public function new( colors_: Array<Int>, triArr: TriangleArray ){
        // store triangles in in serializable structure.
        colors = colors_;
        triSerializeArr = toSerializeArray( triArr );
    }
    public function getTriangles():TriangleArray {
        return toTriangleArray( triSerializeArr );
    }
    static function toSerializeArray( triArr: TriangleArray ): Array<TriangleSerializer> {
        var arr: Array<TriangleSerializer> = [];
        for( i in 0...triArr.length ) arr[ i ] = new TriangleSerializer( triArr[ i ] );
        return arr;
    }
    static function toTriangleArray( arrSerializer: Array<TriangleSerializer>, ?clear: Bool = false ): TriangleArray {
        var arr = new TriangleArray();
        for( i in 0...arrSerializer.length ) {
            arr[ i ] = arrSerializer[ i ].triangle;
            if( clear ) arrSerializer[ i ] = null; // destroy.
        }
        if( clear ) arrSerializer = null;
        return arr;
    }
}
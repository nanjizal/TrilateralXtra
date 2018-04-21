package trilateralXtra.kDrawing;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import trilateralXtra.kDrawing.PolyPainter;
import hxPolyK.PolyK;
import trilateralXtra.kDrawing.ImageDrawing;
class ImageDrawingPolyK extends ImageDrawing {
    public
    function new( ?w: Int, ?h: Int ){
        super( w, h );
    }
    override public
    function fill( p: Array<Array<Float>>, colorID: Int ){
        var l = p.length;
        for( i in 0...l ) if( p[ i ].length != 0 ) fillTriangles( p[ i ], colorID );
    }
    inline
    function fillTriangles( poly: Array<Float>, colorID: Int ): Void {
        var tgs = PolyK.triangulate( poly ); 
        var triples = new ArrayTriple( tgs );
        for( tri in triples ){
            var a: Int = Std.int( tri.a*2 );
            var b: Int = Std.int( tri.b*2 );
            var c: Int = Std.int( tri.c*2 );
            triangles.drawTriangle(  count, { x: poly[ a ], y: poly[ a + 1 ] }
                                       , { x: poly[ b ], y: poly[ b + 1 ] }
                                       , { x: poly[ c ], y: poly[ c + 1 ] }, colorID );
        }
    }
    override public
    function fillRnd( p: Array<Array<Float>>, rnd: Int ){
        var l = p.length;
        for( i in 0...l ) if( p[ i ].length != 0 ) fillTrianglesRnd( p[ i ], rnd );
    }
    inline
    function fillTrianglesRnd( poly: Array<Float>, rnd: Int ): Void {
        var tgs = PolyK.triangulate( poly ); 
        var triples = new ArrayTriple( tgs );
        for( tri in triples ){
            var a: Int = Std.int( tri.a*2 );
            var b: Int = Std.int( tri.b*2 );
            var c: Int = Std.int( tri.c*2 );
            triangles.drawTriangle(  count, { x: poly[ a ], y: poly[ a + 1 ] }
                                       , { x: poly[ b ], y: poly[ b + 1 ] }
                                       , { x: poly[ c ], y: poly[ c + 1 ] }, Std.int( Math.round( Math.random()*rnd ) ) );
        }
    }
    override public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
}
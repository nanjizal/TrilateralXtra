package trilateralXtra.parsing;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import hxGeomAlgo.Tess2;
import hxPolyK.PolyK;// for arrayTriple
import trilateral.parsing.FillDraw;
class FillDrawTess2 extends FillDraw {
    public
    function new( ?w: Int, ?h: Int ){
        super( w, h );
    }
    override public
    function fill( p: Array<Array<Float>>, colorID: Int ){
        var res = Tess2.tesselate( p, null, ResultType.POLYGONS, 3 );
        /*
        var polys = Tess2.convertResult(res.vertices, res.elements, resultType, polySize);
        for( p in polys ){
                    triangles.drawTriangle(  id, { x: p[0].x, y: p[0].y }
                                              , { x: p[1].x, y: p[1].y }
                                              , { x: p[2].x, y: p[2].y }, colorID );
        }*/
        var poly_ = res.vertices;
        var triples = new ArrayTriple( res.elements );
        for( tri in triples ){
            var a: Int = Std.int( tri.a*2 );
            var b: Int = Std.int( tri.b*2 );
            var c: Int = Std.int( tri.c*2 );
            triangles.drawTriangle(  count, { x: poly_[ a ], y: poly_[ a + 1 ] }
                                       , { x: poly_[ b ], y: poly_[ b + 1 ] }
                                       , { x: poly_[ c ], y: poly_[ c + 1 ] }, colorID );
        }
    }
    override public
    function fillRnd( p: Array<Array<Float>>, rnd: Int ){
        var res = Tess2.tesselate( p, null, ResultType.POLYGONS, 3 );
        /*
        var polys = Tess2.convertResult(res.vertices, res.elements, resultType, polySize);
        for( p in polys ){
                    triangles.drawTriangle(  id, { x: p[0].x, y: p[0].y }
                                              , { x: p[1].x, y: p[1].y }
                                              , { x: p[2].x, y: p[2].y }, Std.int( Math.round( Math.random()*rnd ) ) );
        }*/
        var poly_ = res.vertices;
        var triples = new ArrayTriple( res.elements );
        for( tri in triples ){
            var a: Int = Std.int( tri.a*2 );
            var b: Int = Std.int( tri.b*2 );
            var c: Int = Std.int( tri.c*2 );
            triangles.drawTriangle(  count, { x: poly_[ a ], y: poly_[ a + 1 ] }
                                       , { x: poly_[ b ], y: poly_[ b + 1 ] }
                                       , { x: poly_[ c ], y: poly_[ c + 1 ] }, Std.int( Math.round( Math.random()*rnd ) ) );
        }
    }
    override public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
}

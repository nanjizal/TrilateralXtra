package trilateralXtra.parsing;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Fine;
import trilateral.path.Base;
import hxGeomAlgo.Tess2;
import hxPolyK.PolyK;// for array Triple
import trilateral.parsing.FillDraw;
class FillDrawTess2 extends FillDraw {
    public
    function new( ?w: Int, ?h: Int ){
        super( w, h );
    }
    override
    function fillFunc( p: Array<Array<Float>> ):TfillDatas {
        var res = Tess2.tesselate( p, null, ResultType.POLYGONS, 3 );
        return { vert: vert, tri: tri }
    }
    override public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
}
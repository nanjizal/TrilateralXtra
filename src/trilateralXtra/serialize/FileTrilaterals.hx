package trilateralXtra.serialize;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
import haxe.io.Bytes;
import hxbit.Serializer;
import trilateral.tri.TrilateralArray;
import trilateralXtra.serialize.VectorShape;
class FileTilaterals {
    public static
    function write( fName: String, triArr: TrilateralArray ){
        // open file for writing
        var fout = File.write( fName, true );
        var s = new hxbit.Serializer();
        // create serialization VectorImage
        var v = new VectorShape( triArr );
        // serialize and write to file
        var bytesOut = s.serialize( v );
        fout.writeBytes( bytesOut, 0, bytesOut.length );
        fout.close();
    }
    public static 
    function read( fName: String ): VectorShape {
        try{
            // get bytes from file
            var bytesIn = File.getBytes( fName );
            // setup deserializer
            var u = new hxbit.Serializer();
            // delerialize to TriangleHolder
            var vectorShape: VectorShape = u.unserialize( bytesIn, VectorShape );
            // print result 
            return vectorShape;
        } catch( e : Dynamic ){
            trace('broken');
            return null;
        }
    }
}
package trilateralXtra.serialize;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
import haxe.io.Bytes;
import hxbit.Serializer;
import trilateral.tri.TriangleArray;
import trilateralXtra.serialize.VectorImage;
class FileTriangles {
    public static
    function write( fName: String, colors: Array<Int>, triArr: TriangleArray ){
        // open file for writing
        var fout = File.write( fName, true );
        var s = new hxbit.Serializer();
        // create serialization VectorImage
        var v = new VectorImage( colors, triArr );
        // serialize and write to file
        var bytesOut = s.serialize( v );
        fout.writeBytes( bytesOut, 0, bytesOut.length );
        fout.close();
    }
    public static
    function read( fName: String ): VectorImage {
        try{
            // get bytes from file
            var bytesIn = File.getBytes( fName );
            // setup deserializer
            var u = new hxbit.Serializer();
            // delerialize to TriangleHolder
            var vectorImage: VectorImage = u.unserialize( bytesIn, VectorImage );
            // print result 
            return vectorImage;
        } catch( e : Dynamic ){
            trace('broken');
            return null;
        }
    }
}
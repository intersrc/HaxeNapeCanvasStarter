import createjs.easeljs.Bitmap;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

class Block extends Actor {
    public function new(x:Float, y:Float) {
        var w = 16;
        var h = 16;

        var body = new Body(BodyType.DYNAMIC, Vec2.weak(x, y));
        body.shapes.add(new Polygon(Polygon.box(w, h)));
        body.setShapeMaterials(Material.wood());

        var display = new Bitmap(Manifest.BMP_BLOCK);
        display.setBounds(0, 0, w, h);

        super(body, display);
    }
}

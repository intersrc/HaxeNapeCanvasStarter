package ;

import createjs.easeljs.Stage;
import createjs.Ticker;
import js.Browser;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.space.Space;

/**
 * ...
 * @author wuyu
 */

class Main {
    static function main() {
        G.autoSize();

        var stage = new Stage( cast Browser.document.getElementById('main-canvas'));

        var gravity = Vec2.weak(0, 600);
        var space = new Space(gravity);

        var blocks = [];
        for (i in 0...10) {
            var block = new Block(G.stageWidth / 2, -32 * (i + 1));
            stage.addChild(block.container);
            stage.update();
            block.body.space = space;
            block.body.angularVel = Math.PI * i;
            blocks.push(block);
        }

        var wallBody = new Body(BodyType.STATIC, Vec2.weak(0, 0));
        wallBody.shapes.add(new Polygon(Polygon.rect(0, G.stageHeight, G.stageWidth, 1, true)));
        wallBody.shapes.add(new Polygon(Polygon.rect(-1, 0, 1, G.stageHeight, true)));
        wallBody.shapes.add(new Polygon(Polygon.rect(G.stageWidth, 0, 1, G.stageHeight, true)));
        wallBody.setShapeMaterials(Material.wood());
        wallBody.space = space;

        var elapsed:Float;
        function update(event):Void {
            elapsed = event.delta / 1000;
            space.step(elapsed);
            for (block in blocks) {
                block.update();
            }
            stage.update(event);
        }

        Ticker.addEventListener('tick', update);
        Ticker.setFPS(60);
    }
}

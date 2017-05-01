package ;

import createjs.easeljs.Stage;
import createjs.Ticker;
import js.Browser;
import nape.geom.Vec2;
import nape.space.Space;

/**
 * ...
 * @author wuyu
 */

class Main {
    static function main() {
        G.autoSize();

        var stage = new Stage( cast Browser.document.getElementById('main-canvas'));

        var gravity = Vec2.weak(0, 0);
        var space = new Space(gravity);

        var block = new Block(375, 667);
        stage.addChild(block.container);
        stage.update();
        block.body.space = space;
        block.body.angularVel = Math.PI;

        var elapsed:Float;
        function update(event):Void {
            elapsed = event.delta / 1000;
            space.step(elapsed);
            block.update();
            stage.update(event);
        }

        Ticker.addEventListener('tick', update);
        Ticker.setFPS(60);
    }
}

package ;

import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import createjs.easeljs.Stage;
import createjs.easeljs.Text;
import createjs.Ticker;
import createjs.preloadjs.LoadQueue;
import createjs.soundjs.Sound;
import js.Browser;
import js.html.CanvasElement;
import js.html.Node;

/**
 * ...
 * @author wuyu
 */

class Preload {
    static function main() {
        G.autoSize();
        var stageWidth = G.stageWidth;
        var stageHeight = G.stageHeight;

        var canvas:CanvasElement = cast Browser.document.getElementById('main-canvas');
        var stage = new Stage(canvas);

        //Preload & Destroy
        var targetJs:String = if (canvas.dataset != null) {
            canvas.dataset.target;
        }
        else {
            canvas.getAttribute('data-target');
        }

        var preload = new LoadQueue();

        var manifest = [
            { id: 'BMP_BLOCK', src: Manifest.BMP_BLOCK },
            { id: targetJs, src: targetJs }
        ];

        if (Sound.initializeDefaultPlugins()) {
            manifest.push( { id: 'hit', src: Manifest.SOUND_HIT } );
        }

        var messageField:Text = new Text('Loading', 'bold 24px Arial', '#FFFFFF');
        messageField.maxWidth = stageWidth;
        messageField.textAlign = 'center';
        messageField.x = stageWidth / 2;
        messageField.y = stageHeight / 2 - 48;
        stage.addChild(messageField);
        stage.update();

        var blocks:Array<Container> = [];
        for (i in 0...20) {
            var bmp:Bitmap = new Bitmap('./assets/block.png');
            bmp.x = -8;
            bmp.y = -8;
            var block:Container = new Container();
            block.addChild(bmp);
            block.x = stageWidth / 2 - 10 * 16 + i * 16 + 8;
            block.y = (stageHeight - 16) / 2 + 8 + 16;
            block.visible = false;
            blocks[i] = block;
            stage.addChild(block);
        }
        var time:Float;
        function update(event):Void {
            time = event.delta / 1000;

            for (i in 0...20) {
                if (blocks[i].visible && (blocks[i + 1] == null || !blocks[i + 1].visible)) {
                    blocks[i].rotation += 360 * time;
                }
                else {
                    blocks[i].rotation = 0;
                }
            }

            stage.update(event);
        }
        Ticker.addEventListener('tick', update);
        Ticker.setFPS(60);

        function updateLoading() {
            var percentStr:String = Std.string(Math.floor(preload.progress * 1000) / 10);
            if (percentStr.indexOf('.') == -1) {
                percentStr += '.0';
            }
            messageField.text = 'Loading ' + percentStr + '%';

            var n:Int = Math.ceil(preload.progress * 20);
            for (i in 0...n) {
                blocks[i].visible = true;
            }

            stage.update();
        }

        var scripts:Array<Node> = [];
        function doneLoading(event) {
            stage.removeAllChildren();
            for (script in scripts) {
                Browser.document.body.appendChild(script);
            }
        }

        function handleFileLoaded(event) {
            var item = event.item;
            var result = event.result;

            if (item.type == LoadQueue.JAVASCRIPT) {
                scripts.push(result);
            }
        }

        preload.installPlugin(Sound);
        preload.addEventListener('complete', doneLoading);
        preload.addEventListener('progress', updateLoading);
        preload.addEventListener('fileload', handleFileLoaded);
        preload.loadManifest(manifest);
    }
}

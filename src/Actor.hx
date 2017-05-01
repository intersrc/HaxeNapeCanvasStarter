package ;
import createjs.easeljs.Container;
import createjs.easeljs.DisplayObject;
import nape.phys.Body;

/**
 * ...
 * @author wuyu
 */
class Actor {
    public var body:Body;
    public var container:Container;
    public var exists:Bool;
    public var linearDragX:Float = 1;
    public var linearDragY:Float = 1;

    public function new(body:Body, display:DisplayObject) {
        this.body = body;
        this.container = new Container();

        var originalBodyX:Float = this.body.position.x;
        var originalBodyY:Float = this.body.position.y;
        var originalBodyRotation:Float = this.body.rotation;

        this.body.position.x = this.body.position.y = 0;
        this.body.rotation = 0;

        var centerX:Float = this.body.bounds.x + this.body.bounds.width / 2;
        var centerY:Float = this.body.bounds.y + this.body.bounds.height / 2;
        display.x = centerX - display.getBounds().width / 2;
        display.y = centerY - display.getBounds().height / 2;
        this.container.addChild(display);

        this.body.position.x = originalBodyX;
        this.body.position.y = originalBodyY;
        this.body.rotation = originalBodyRotation;

        this.exists = true;

        update();
    }

    public function update():Void {
        if (this.exists) {
            this.container.x = this.body.position.x;
            this.container.y = this.body.position.y;

            if (this.body.allowRotation) {
                this.container.rotation = this.body.rotation * 180 / Math.PI;
            }

            if (this.linearDragX < 1) {
                this.body.velocity.x *= this.linearDragX;
            }
            if (linearDragY < 1) {
                this.body.velocity.y *= this.linearDragY;
            }
        }
    }

    public function destroy():Void {
        this.exists = false;
        if (this.body != null) {
            if (this.body.space != null) {
                this.body.space.bodies.remove(body);
            }
            this.body = null;
        }
        if (this.container != null) {
            if (this.container.parent != null) {
                this.container.parent.removeChild(this.container);
            }
            this.container = null;
        }
    }
}

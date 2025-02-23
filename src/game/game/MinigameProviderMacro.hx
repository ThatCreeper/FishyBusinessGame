package game.game;

import haxe.macro.Expr.TypePath;
import haxe.macro.Expr.Field;
import haxe.macro.Context;

class MinigameProviderMacro {
    public static macro function build(name:String, clazz:String): Array<Field> {
        var fields = Context.getBuildFields();
        var pos = Context.currentPos();

        fields.push({
            name: "new",
            access: [APublic],
            kind: FFun({
                args: [],
                expr: macro {}
            }),
            pos: pos
        });

        fields.push({
            name: "getName",
            access: [APublic],
            kind: FFun({
                args: [],
                ret: macro:String,
                expr: macro return $v{name}
            }),
            pos: pos
        });

        var path: TypePath = {
            pack: ["game", "game"],
            name: clazz
        };

        fields.push({
            name: "make",
            access: [APublic],
            kind: FFun({
                args: [],
                ret: macro:Minigame,
                expr: macro return new $path ()
            }),
            pos: pos
        });

        return fields;
    }
}
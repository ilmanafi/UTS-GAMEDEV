package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;

import flash.system.System;
/**
 * ...
 * @author Christever
 */
class MenuState extends FlxState 
{
	
	private var _selected:Int = 0;

	private var _menuEntries:Array<String> = ["NEW GAME", "INSTRUCTIONS", "CREDITS", "EXIT"];
	private var _menuPos:FlxPoint = new FlxPoint(132, 90);
	private var _menuSpacing:Int = 16;
	
	private var _cursor:FlxSprite;
	
	override public function create():Void
	{
		FlxG.sound.playMusic("intro", 10,true);
		_cursor = new FlxSprite(_menuPos.x - _menuSpacing, _menuPos.y );
		_cursor.loadGraphic(AssetPaths.HUD__png, true,16,16);
		_cursor.animation.add("cursor", [0]);
		_cursor.animation.play("cursor");
		add(_cursor);
		
		for (i in 0..._menuEntries.length)
		{
			var entry:FlxText = new FlxText(_menuPos.x, _menuPos.y + _menuSpacing * i);
			entry.text = _menuEntries[i];
			add(entry);
		}
		forEachOfType(FlxText, function (member)
		{
			member.setFormat(AssetPaths.ARCADECLASSIC__TTF, 16, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE);
			
		});
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([Z, UP])){
			_selected -= 1;
		}
		if (FlxG.keys.anyJustPressed([S, DOWN])){
			_selected += 1;
		}
		
		_selected = FlxMath.wrap(_selected, 0, _menuEntries.length - 1);
		_cursor.y = _menuPos.y + _menuSpacing * _selected;
		
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.sound.music.stop();
			switch (_selected) 
			{
				case 0:
					FlxG.switchState(new PlayState());
				case 1:
					FlxG.switchState(new Instructions());
				case 2:
					FlxG.switchState(new Credits());
				case 3:
					System.exit(0);
				default:
					
			}
		}
	}
	
}
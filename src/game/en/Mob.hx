package en;

class Mob extends Entity {
	public static var ALL : FixedArray<Mob> = new FixedArray(40);
	var data : Entity_Mob;

	public function new(d) {
		data = d;
		super();
		useLdtkEntity(data);
		ALL.push(this);
		initLife(2);

		spr.set(Assets.entities);
		var f = new dn.heaps.filter.PixelOutline( Assets.dark() );
		f.bottom = false;
		spr.filter = f;

		spr.anim.registerStateAnim(D.ent.mIdle, 0);
	}

	override function hit(dmg:Int, from:Null<Entity>) {
		super.hit(dmg, from);
		setSquashX(0.4);
		blink(dmg==0 ? White : Red);
		spr.anim.playOverlap(D.ent.mHit);
	}

	override function dispose() {
		super.dispose();
		ALL.remove(this);
	}

	inline function aiLocked() {
		return !isAlive() || hasAffect(Stun);
	}

	override function fixedUpdate() {
		super.fixedUpdate();

		if( !aiLocked() ) {
			dir = dirTo(hero);
		}
	}

}
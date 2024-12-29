package game.game;

import hxd.Timer;
import hxd.Key;

enum Page {
    Typing;
    Store;
    Hacker;
}

class ClickerGame extends Game {
    public var bg: BackgroundEntity;
    public var sidebar: SidebarEntity;
    public var pageentity: Entity<ClickerGame>;

    // State
    public var page = Page.Typing;
    public var cash = 200;
    public var totalcash = 200;
    public var mostcash = 0;
    public var luigiprob = 0.0;
    public var totalletters = 0;
    public var letters = 0;
    public var lettersToPost = 30;
    public var cashPerEmail = 1;
    public var hackerProg = 0.0;
    public var hackerPts = 0;

    var timeUntilLuigi = 120.0;

    public function new() {
        super();
        camera.centered = false;

        bg = new BackgroundEntity(this);
        sidebar = new SidebarEntity(this);

        typingPage();

        bg.instant();
    }

    override function update() {
        super.update();

        timeUntilLuigi -= Timer.dt;
        if (timeUntilLuigi <= 0) {
            timeUntilLuigi = 120;
            var roll = Math.random();
            if (roll < luigiprob)
                trace("Killed");
        }
    }

    public function typingPage() {
        page = Page.Typing;
        sidebar.title = "Electro-Mail";
        pageentity?.remove();
        pageentity = new TypingPageEntity(this);
    }

    public function storePage() {
        page = Page.Store;
        sidebar.title = "Electro-Shop";
        pageentity?.remove();
        pageentity = new ShopPageEntity(this);
    }

    public function hackerPage() {
        page = Page.Hacker;
        sidebar.title = "Hacker Chat";
        pageentity?.remove();
        pageentity = new HackerPageEntity(this);
    }

    public function luigi() {
        luigiprob += 0.02;
        luigiprob *= 1.3;
    }

    public function sendmail() {
        cash += cashPerEmail;
        totalcash += cashPerEmail;
        if (cash > mostcash)
            mostcash = cash;
    }

    public function charity() {
        luigiprob -= 0.04;
        if (luigiprob < 0)
            luigiprob = 0;
    }
}
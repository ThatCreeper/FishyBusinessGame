package game.game;

import hxd.Key;

enum Page {
    Typing;
    Store;
}

class ClickerGame extends Game {
    public var bg: BackgroundEntity;
    public var sidebar: SidebarEntity;
    public var pageentity: Entity<ClickerGame>;

    // State
    public var page = Page.Typing;
    public var cash = 0;

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
}
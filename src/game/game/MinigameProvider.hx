package game.game;

interface MinigameProvider {
    function getName(): String;
    function make(): Minigame;
}
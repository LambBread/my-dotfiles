// ==UserScript==
// @name         Remove Reddit Answers Button
// @namespace    http://tampermonkey.net/
// @version      2025-12-09
// @description  Removes the Reddit answers button.
// @author       You
// @match        https://www.reddit.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=mozilla.org
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
        setTimeout(()=>{
            const searchBar = document.querySelector("reddit-search-large").shadowRoot;
            const faceplate = searchBar.querySelector("faceplate-search-input").shadowRoot;
            const clanker = faceplate.querySelector(".trailing-content-container");
            clanker.remove();
            console.log("removed clanker button");
        }, 2200);
})();

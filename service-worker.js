/**
 * Copyright 2016 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

// DO NOT EDIT THIS GENERATED OUTPUT DIRECTLY!
// This file should be overwritten as part of your build process.
// If you need to extend the behavior of the generated service worker, the best approach is to write
// additional code and include it using the importScripts option:
//   https://github.com/GoogleChrome/sw-precache#importscripts-arraystring
//
// Alternatively, it's possible to make changes to the underlying template file and then use that as the
// new base for generating output, via the templateFilePath option:
//   https://github.com/GoogleChrome/sw-precache#templatefilepath-string
//
// If you go that route, make sure that whenever you update your sw-precache dependency, you reconcile any
// changes made to this original template file with your modified copy.

// This generated service worker JavaScript will precache your site's resources.
// The code needs to be saved in a .js file at the top-level of your site, and registered
// from your pages in order to be used. See
// https://github.com/googlechrome/sw-precache/blob/master/demo/app/js/service-worker-registration.js
// for an example of how you can register this script and handle various service worker events.

/* eslint-env worker, serviceworker */
/* eslint-disable indent, no-unused-vars, no-multiple-empty-lines, max-nested-callbacks, space-before-function-paren, quotes, comma-spacing */
'use strict';

var precacheConfig = [["/404.html","67ca60f83b50ab3cce31b165033e468b"],["/about-blog-comments/index.html","638ed72dd11163d3c4d32e43944595cc"],["/about/index.html","f491b4a14bbbf3d2c1de65b6720a420c"],["/alfred-for-mac/index.html","6047b7a12ee3e3b95e6851a27f406a20"],["/angel/index.html","d07c511edcb79526381a52554736a10d"],["/assets/favicons/favicon.png","9904adee1ce0a9a4f74a22707e5a1bfc"],["/assets/icons/search.png","5ccc181c515c758b996fd70aa7a12f35"],["/assets/images/avatar.jpg","25270194d2434e74dcd75cc26d82c14d"],["/assets/images/cover.jpg","74f9fcdcf05edd8ef345b01923fc01b5"],["/assets/images/icon-128x128.png","ba99fb8f6cf6f7db3685702528ea3c79"],["/assets/images/icon-144x144.png","69a8fb36c2d8cdd4bf5b5e03db8bd53c"],["/assets/images/icon-152x152.png","aae648fcc722c319f3005522c195eb65"],["/assets/images/icon-192x192.png","477555ce54a5b90446078bdfc2a8563d"],["/assets/images/icon-384x384.png","de9ef03cb67f6d4c6482ca8c0a0f4d1b"],["/assets/images/icon-512x512.png","9c56ad5086e9c004cb0a10e3c88aa0a4"],["/assets/images/icon-72x72.png","dfdb1f4566fc69cb332cddca4270420d"],["/assets/images/icon-96x96.png","6109838b34d20d2413510bb45ace1bf0"],["/assets/images/logo.jpg","0d6a425e0fd0c527740d8d749a800817"],["/assets/images/meta_icon.jpg","0d6a425e0fd0c527740d8d749a800817"],["/blog/2015/07/fix-unknown-option-q-nvm/index.html","230d18e6168cbb31b1f503d4743504ff"],["/blog/2015/07/index.html","45e254339e8067d622193d943a8884ab"],["/blog/2015/08/fix-electron-installjs-error-when-root/index.html","bbdcbc0429487dabc01430ec93e0c969"],["/blog/2015/08/fix-locking-eacces-error-npm-osx/index.html","5c49677ff8cec92dc2cb8f97192205d3"],["/blog/2015/08/getting-git-bash-completion/index.html","b34d5776f624f1ea2b2456570683f676"],["/blog/2015/08/index.html","7a91b164f8885da354bd7d6046d09102"],["/blog/2015/08/node-installation-best-practise/index.html","817f16d8726efecd9924bb72b8665a44"],["/blog/2015/10/getting-bash-completion/index.html","fb6b76aef0c9bf9c90c5d356ede74dc9"],["/blog/2015/10/index.html","dcf6cbc94bacac9535e97c310ca94f44"],["/blog/2015/10/my-2-cents-guide-for-a-safe-upgrade-to-el-capitan/index.html","194bc77639412eb0f710fa40e7615d73"],["/blog/2015/10/restore-old-apache-conf-after-osx-upgrade/index.html","87a68c3be06833db7726aa6e4a3beea4"],["/blog/2016/01/azure-attach-vhds/index.html","ecb5d074e140e95030aecd2d6b6e4695"],["/blog/2016/01/git-crypt/index.html","2c70ddb3c607d6f1bb0368f09827714a"],["/blog/2016/01/git-install-from-source/index.html","206a854a5b7bddeb87f7660d380d49a8"],["/blog/2016/01/github-pages/index.html","ffec0c3a904707ccfaa47d532a1e441a"],["/blog/2016/01/gmail-inbox/index.html","e8cb1a196c7fde55655c04bf9ac9d646"],["/blog/2016/01/gollum/index.html","a275df3805ca38da09c3e4722802d891"],["/blog/2016/01/index.html","e6e2a92d00227730c480867150f906b4"],["/blog/2016/01/veertu/index.html","f65133c070af3e468a48472881df7f18"],["/blog/2016/02/apple-vs-fbi-collection/index.html","628d92a26baca49348b988bebb99a8d6"],["/blog/2016/02/index.html","8d60532e1592d8bca515638950adf8ce"],["/blog/2016/02/issue-renew-ssl-certs-startssl/index.html","b374e37c965297c070ecdf9d93ddffe6"],["/blog/2016/02/osx-disable-per-session-history/index.html","0096ff2a8ae4288ddb97c01c28818649"],["/blog/2016/02/restore-battery-icon-elementary/index.html","93eb668a628148d14682a1ebaee74437"],["/blog/2016/02/sparkle-security-issue/index.html","8ae7723a492d813cf3eda4270365b078"],["/blog/2016/04/index.html","f722ef72f60964e42498282aceccd082"],["/blog/2016/04/install-php-raspberry-pi/index.html","34af7e81d14b7ccee80222ad25f3fbe6"],["/blog/2016/05/index.html","3f48178c91c59d0fb666c6ae07fa1d93"],["/blog/2016/05/speech-the-sexy-side-of-javascript-nodejs/index.html","1992b564c9b351bd9083abe222e8968a"],["/blog/2016/09/generate-your-index.html/index.html","dca593ce0a22f467f163292a4e46acdc"],["/blog/2016/09/index.html","af30ed4d89bcd755720dd0275c4278d7"],["/blog/2016/09/ios10-review/index.html","38a43c0e2b326163d7d4251c3e70b499"],["/blog/2016/09/migrate-bazaar-to-git/index.html","ef9231cdf9bedcf82b019c7c386ab8e4"],["/blog/2016/09/my-jekyll-workflow-part1/index.html","38a8b279b6aa50e2a08beac84d485635"],["/blog/2016/09/my-jekyll-workflow-part2/index.html","f37b188a77715b680c894c42def42a21"],["/blog/2016/09/my-jekyll-workflow-part3/index.html","ab3139f9a7842fe43dc03c8b0b9e827b"],["/blog/2016/09/windows10-grub/index.html","06539b56d7372c4477e81de57b65ae57"],["/blog/2016/10/index.html","f784865c69bce3dde5d6c07ec78eaf02"],["/blog/2016/10/installing-git-from-source/index.html","7b0aead382977821cbb4a769acdcb0e9"],["/blog/2016/10/thoughts-on-the-new-macbook-pro/index.html","ce892ce4e6e864eea0ebc44d5b6fd78a"],["/blog/2016/11/index.html","ed26686bd79f5e556cca592a9e99aa6e"],["/blog/2016/11/macos-security-list/index.html","7c4d5cc4bc9d7f1f845543538b73e35f"],["/blog/2017/01/icloud-photos-under-the-hood/index.html","211053a9e7bd2e45aac7cd6226f6907a"],["/blog/2017/01/index.html","db692dcf3ac1ae4eadfcf366127b19c5"],["/blog/2017/03/free-other-space-on-ios/index.html","d35d2ecdb32db21178eb75fb80a57536"],["/blog/2017/03/index.html","fb752a3c7fdd21e2f781f906d379ccf0"],["/blog/2017/03/jdeveloper-error-401/index.html","2a6011f47c8a5a97a12ca61634b4317e"],["/blog/2017/03/troubleshooting-jdeveloper/index.html","1a8e91ec77d6cbd8549fd19f25013045"],["/blog/2017/04/forgotten-integrated-weblogic-credentials/index.html","f6568e37ac9ab2ef9ebb787dba02eaf9"],["/blog/2017/04/index.html","b097cf00bcbd4acc09c9c363b9299e98"],["/blog/2017/04/jdeveloper-service-dir-is-not-valid/index.html","f837aed39ddcd8518a9548a59e6b2bf9"],["/blog/2017/04/multiple-jdeveloper-installations/index.html","8d9493c0b22ff7a9088bb78cb331003a"],["/blog/2017/04/xml-validation-tools-on-windows/index.html","3da2643108a48fbcc898b40ee8a14300"],["/blog/categories/articles/index.html","c4b20980dd23d0af954d886100bf3d64"],["/blog/categories/guides/index.html","82c2ad5708c1c6a1abd002118c48144a"],["/blog/categories/how-tos/index.html","f8fac7cbf1ef0a2f057a5dc1449487d0"],["/blog/categories/index.html","2ac9778b5b79b8b357c850f0dd304c3c"],["/blog/categories/reviews/index.html","2cd2e55f5fced25df3651f4b76f005f2"],["/blog/categories/tutorials/index.html","d238dfac522c4dea158e0e0786e027ad"],["/blog/index.html","8ae37b016a452e23e1164d8111ad0a33"],["/blog/tags/apache/index.html","d3be638c7769d0d2d4de228367ac762f"],["/blog/tags/apple/index.html","0dee64c64e5e57461cdbaaef66cb3f47"],["/blog/tags/aws/index.html","40d58811d51803703167e388bc36ac50"],["/blog/tags/bash/index.html","e3f64b10ae21a23b08193895d92b2af5"],["/blog/tags/best-practices/index.html","b24705ecbed772eadc68d0be1efa919d"],["/blog/tags/blogging/index.html","86dabeed52e0e4982abbadaabb3de445"],["/blog/tags/centos/index.html","51cfae12fef60b73a31ff3f74f75e012"],["/blog/tags/cloud/index.html","490a6b11cf6a599d886a5dbb6387503e"],["/blog/tags/debian/index.html","a51e558e6d94b49e154572c8ea4f1ad4"],["/blog/tags/editor/index.html","a7ac19f71bd7f44a48a091eddfca7a86"],["/blog/tags/electron/index.html","a36f052c79886b9b0cda0723c0f349a4"],["/blog/tags/elementaryos/index.html","068cf43a7ed89854b7b0bee59ca661ad"],["/blog/tags/es2015/index.html","10680b9dafee728d0dadcd406035f700"],["/blog/tags/git/index.html","4e093e04e88943813a3989fd0f1c135e"],["/blog/tags/github/index.html","ee628b16d11ab12e7be795268415b4d2"],["/blog/tags/gitlab/index.html","2472a4b339803fb1f4fcda703e6afed3"],["/blog/tags/google/index.html","b8e6a3c70152462d15b7ac4972345e78"],["/blog/tags/grub/index.html","c4bf8b556377fd52e7b22ec5a5b3c021"],["/blog/tags/index.html","7383a8720a1f633c3b0d0407fdacc50c"],["/blog/tags/ios/index.html","dba9c9c84677fc4ac8716b5ade59d66b"],["/blog/tags/ipad/index.html","756bb9000617a61d6854b2f1f44fcf16"],["/blog/tags/javascript/index.html","788ef2f4b306d0ebf178787c87990494"],["/blog/tags/jdeveloper/index.html","29a137029bdbc66e5b39fe54e417963c"],["/blog/tags/jekyll/index.html","e935a0d1be15c3985a97693cdcdefe24"],["/blog/tags/linux/index.html","a54988b6db62d34f0d408c3a59b60d4f"],["/blog/tags/macos/index.html","368627362c67b3e0f7a476bd0fed9e4d"],["/blog/tags/microsoft-azure/index.html","77e42626363a9a064419fa113e8cf1ee"],["/blog/tags/nginx/index.html","63bc58c1e7f74c5b84c98bfbc588d117"],["/blog/tags/node-js/index.html","69dbb92c1506fd4e2648873b265145e2"],["/blog/tags/oracle/index.html","0ead10703fa07361d6442838bf8ce920"],["/blog/tags/php/index.html","76b9221c1a9c40d5e80441079c497ab2"],["/blog/tags/privacy/index.html","31e9ad1e77719fc3fb94223985987a44"],["/blog/tags/pythonista/index.html","1e921e6d363741262c5daea8fcd4fd75"],["/blog/tags/raspberry-pi/index.html","16af94592bdded42b1d5bd1cb6211cbc"],["/blog/tags/review/index.html","8c17cde4c4a91f339dd2a8ebca2fa5c8"],["/blog/tags/security/index.html","160b629f6193abcd63022d1a64a63e25"],["/blog/tags/ssl/index.html","5a8a43e664c081e088c733648605001a"],["/blog/tags/sublime-text/index.html","5ec57e4dc6f63cc2f157ea6ff187d34e"],["/blog/tags/sys-admin/index.html","68b6a5a1d7f5f2f0c593474275081813"],["/blog/tags/virtualisation/index.html","df6ed7d20870abdc2289df45735ecc73"],["/blog/tags/windows-10/index.html","028531045715d887b4b148aeae0aa941"],["/blog/tags/windows/index.html","b0c4d5976e61dfdc6a2f5db17e8ebd04"],["/blog/tags/xml/index.html","ed2c557dc2a5192425e97cabe96e715d"],["/calendars/itcalendar/index.html","7d58c654100c60d1cc41ac7f4e5a64f5"],["/contacts/index.html","1dbaad28da19560b0043a81892fdf098"],["/css/pages/blog.css","c87718153e112a5b6fe317c4c07f8575"],["/css/pages/deals.css","36f044b88269d0df26b080cf52e548a2"],["/css/pages/home.css","c4e190d2ba1bf1ebf3d5eb61d8e14078"],["/css/pages/more.css","76e0867756f312fa6b68f7b389c67aa1"],["/css/pages/quotes.css","bec89cfd892675aff98faffaa8802f11"],["/css/pages/search.css","60ca92482fde21d2140c219693e30da0"],["/css/posts/posts.css","5aee0f3c7704e7764fe875ab2d1ab3f6"],["/css/projects/ble.css","5d16e97661d7ce69209ced691a7a195a"],["/css/projects/projects.css","f06339a63e7c9971f04b9afd749fa884"],["/css/utilities/bfc.css","77ab8b799cf730fc3b74a034f4b87e3c"],["/deals/index.html","bac5e89ce850710a6a1ea7afc6e8319d"],["/developers/index.html","0bfde3f49fba0b5ba01fc5f370b754b9"],["/dribbble/index.html","d07c511edcb79526381a52554736a10d"],["/events/index.html","791dfe1bd7db20334b338e3b876eb084"],["/facebook/index.html","d07c511edcb79526381a52554736a10d"],["/flickr/index.html","d07c511edcb79526381a52554736a10d"],["/for-developers/index.html","d80c4b900c764ede1850749f9da9be7e"],["/for-users/index.html","de7f612f21b4c11881ae0d8f3bc8a3b8"],["/gist/index.html","d07c511edcb79526381a52554736a10d"],["/github/index.html","d07c511edcb79526381a52554736a10d"],["/goodies/index.html","b9ec80ace8567efbcfb21add021f5763"],["/goodreads/index.html","d07c511edcb79526381a52554736a10d"],["/google+/index.html","d07c511edcb79526381a52554736a10d"],["/google22694754120b0882.html","4d788566dca56f3e7aec6d02b05d0632"],["/help/no-javascript/index.html","a1e82eebfe95459c2b7d685564e85be2"],["/index.html","43d51166762258c34d2810d68600070b"],["/inspiring/index.html","fc4436ed00b06e6f6dcacb59c5048221"],["/instagram/index.html","d07c511edcb79526381a52554736a10d"],["/js/jquery-1.11.3.min.js","f03e5a3bf534f4a738bc350631fd05bd"],["/js/lunr.min.js","b61a88b241a3be5a61d1c041622f3556"],["/js/page_anchors.js","f7c1f36d7dffc80fade6cf25c8efb7c6"],["/js/pages/support.js","cd4614720e4696ba7567e23c736959bd"],["/js/search.js","96cbc126eeac700d3dea3a35e1563165"],["/js/service-worker-register.js","d60f01dc1393cbaaf4f7435339074d5e"],["/js/utilities/bfc.js","5d40bdde827f2cb985570a81ca6f069e"],["/js/velocity.min.js","c1b8d079c7049879838d78e0b389965e"],["/keybase/index.html","d07c511edcb79526381a52554736a10d"],["/lastfm/index.html","d07c511edcb79526381a52554736a10d"],["/linkedin/index.html","d07c511edcb79526381a52554736a10d"],["/medium/index.html","d07c511edcb79526381a52554736a10d"],["/my-toolbelt/index.html","5065cc72d358cea3ce5f2214666ab863"],["/news/index.html","cb0e851b02225b9e5a3609a91bd7bb33"],["/pages/disabled/more.html","9c62363edf89df3956b6d237a604bc98"],["/pgp/index.html","b270c0a9284832f15741e5e754d0217b"],["/pinterest/index.html","d07c511edcb79526381a52554736a10d"],["/pocket/index.html","d07c511edcb79526381a52554736a10d"],["/projects/ble/index.html","c898f78aceac6690039fa9362ebd6880"],["/projects/electron-dash/index.html","c66c8cb86dae4fac6fb94154cb67ca08"],["/projects/index.html","bd98caecb58417615f05f24e372687d5"],["/projects/rebrandly_cli/index.html","b14b6d8b509b322fb8ab8b70c1a3e5fd"],["/projects/workflow-ios/index.html","2c5adbdfabf143ce401ec686df6115d4"],["/quotes/index.html","7112130472e7012b05ec8f0e9295a9b3"],["/reddit/index.html","d07c511edcb79526381a52554736a10d"],["/referrals/index.html","73356cc1eb6ed524c79723e884581d12"],["/search/index.html","1ff5054f3c265c6322aa5b850f077e16"],["/security/index.html","5cb338fd99cb6fca3dcd2b3ae0cf3319"],["/slideshare/index.html","d07c511edcb79526381a52554736a10d"],["/social/index.html","4a8ada96f1415724a2844253061529bb"],["/soundcloud/index.html","d07c511edcb79526381a52554736a10d"],["/stackoverflow/index.html","d07c511edcb79526381a52554736a10d"],["/static/postimages/2016-01-08/001.jpg","a4e69546581e53bbedc694a6a46a6b37"],["/static/postimages/2016-01-19/001.png","848e6982b9a3ef6d187f8b01522701a9"],["/static/postimages/2016-01-29/001.jpg","04dbea728ae580d3d71a93d9267b6dc7"],["/static/postimages/2016-01-29/002.jpg","9556135c46454de59e61c0cc71b1f725"],["/static/postimages/2016-02-10/001.png","05539d020d2c52386c00fd5590efdf2d"],["/static/postimages/2016-02-10/002.png","327fcfceb055e1f2ae3e67feca6f5097"],["/static/postimages/2016-02-10/003.png","d5ea93f330be4746824a4678625d02f2"],["/static/postimages/2016-05-17/001.jpg","cdf00aff76933b499fd7bd37d8dbeef5"],["/static/postimages/2016-05-17/002.jpg","c40ad765b80f30cb19464adbe6a53f61"],["/static/postimages/2017-01-31/001.png","48d76bf3345f54a8693d720f5468585c"],["/static/postimages/2017-01-31/002.png","d91d933c29ea6e48b61ad08623be1815"],["/static/postimages/2017-03-30/troubleshooting_jdeveloper_p2_error.png","77fd70508ee661519354de826d55aaac"],["/static/postimages/backlighter-fixer-for-linux/001.png","2119805f7deb27bce7938bf9896f18b7"],["/static/postimages/backlighter-fixer-for-linux/002.png","afe6672055d1bcb0a7083a7c4ad67cb1"],["/static/postimages/gen_index/001.png","fab28c7bd7e5289831c9165a2f0614a4"],["/static/postimages/itunes-podcasts-smart-playlists/001.png","06515ec244a7ec82f73d183ec84fa156"],["/static/postimages/partition-alignment/001.png","0ec1ae28558be80c168fdf7256588395"],["/static/postimages/partition-alignment/002.png","69d401b662f4e2c56c6c223d611ba76d"],["/static/postimages/partition-alignment/003.png","4b277abd28837173497f1dbe3ef1b3a6"],["/static/projectimages/ble/charging.png","9a740fb6f0855159b7af5378c0fd1f4e"],["/static/projectimages/ble/discharging.png","6136daf80ac059274e475d3b54c3646b"],["/subscribe/index.html","f8ae7fcadd014505621602efc586be92"],["/support/index.html","92e416bd4e87754814000484f8e6a6f9"],["/talks/index.html","ef5d8f7a3115d0a319494c307b2b8342"],["/terms/index.html","034b7f376244d73eedb1306e03c0e22a"],["/test/index.html","c111b338c6464bc61915be92b868277b"],["/tumblr/index.html","d07c511edcb79526381a52554736a10d"],["/twitter/index.html","d07c511edcb79526381a52554736a10d"],["/utilities/bfc/index.html","de196d65937fb0af3cfefc6733160d89"],["/utilities/index.html","3399ee83b6b4f753cd00d7529d2c7890"],["/youtube/index.html","d07c511edcb79526381a52554736a10d"]];
var cacheName = 'sw-precache-v3-sw-precache-' + (self.registration ? self.registration.scope : '');


var ignoreUrlParametersMatching = [/^utm_/];



var addDirectoryIndex = function (originalUrl, index) {
    var url = new URL(originalUrl);
    if (url.pathname.slice(-1) === '/') {
      url.pathname += index;
    }
    return url.toString();
  };

var cleanResponse = function (originalResponse) {
    // If this is not a redirected response, then we don't have to do anything.
    if (!originalResponse.redirected) {
      return Promise.resolve(originalResponse);
    }

    // Firefox 50 and below doesn't support the Response.body stream, so we may
    // need to read the entire body to memory as a Blob.
    var bodyPromise = 'body' in originalResponse ?
      Promise.resolve(originalResponse.body) :
      originalResponse.blob();

    return bodyPromise.then(function(body) {
      // new Response() is happy when passed either a stream or a Blob.
      return new Response(body, {
        headers: originalResponse.headers,
        status: originalResponse.status,
        statusText: originalResponse.statusText
      });
    });
  };

var createCacheKey = function (originalUrl, paramName, paramValue,
                           dontCacheBustUrlsMatching) {
    // Create a new URL object to avoid modifying originalUrl.
    var url = new URL(originalUrl);

    // If dontCacheBustUrlsMatching is not set, or if we don't have a match,
    // then add in the extra cache-busting URL parameter.
    if (!dontCacheBustUrlsMatching ||
        !(url.pathname.match(dontCacheBustUrlsMatching))) {
      url.search += (url.search ? '&' : '') +
        encodeURIComponent(paramName) + '=' + encodeURIComponent(paramValue);
    }

    return url.toString();
  };

var isPathWhitelisted = function (whitelist, absoluteUrlString) {
    // If the whitelist is empty, then consider all URLs to be whitelisted.
    if (whitelist.length === 0) {
      return true;
    }

    // Otherwise compare each path regex to the path of the URL passed in.
    var path = (new URL(absoluteUrlString)).pathname;
    return whitelist.some(function(whitelistedPathRegex) {
      return path.match(whitelistedPathRegex);
    });
  };

var stripIgnoredUrlParameters = function (originalUrl,
    ignoreUrlParametersMatching) {
    var url = new URL(originalUrl);
    // Remove the hash; see https://github.com/GoogleChrome/sw-precache/issues/290
    url.hash = '';

    url.search = url.search.slice(1) // Exclude initial '?'
      .split('&') // Split into an array of 'key=value' strings
      .map(function(kv) {
        return kv.split('='); // Split each 'key=value' string into a [key, value] array
      })
      .filter(function(kv) {
        return ignoreUrlParametersMatching.every(function(ignoredRegex) {
          return !ignoredRegex.test(kv[0]); // Return true iff the key doesn't match any of the regexes.
        });
      })
      .map(function(kv) {
        return kv.join('='); // Join each [key, value] array into a 'key=value' string
      })
      .join('&'); // Join the array of 'key=value' strings into a string with '&' in between each

    return url.toString();
  };


var hashParamName = '_sw-precache';
var urlsToCacheKeys = new Map(
  precacheConfig.map(function(item) {
    var relativeUrl = item[0];
    var hash = item[1];
    var absoluteUrl = new URL(relativeUrl, self.location);
    var cacheKey = createCacheKey(absoluteUrl, hashParamName, hash, false);
    return [absoluteUrl.toString(), cacheKey];
  })
);

function setOfCachedUrls(cache) {
  return cache.keys().then(function(requests) {
    return requests.map(function(request) {
      return request.url;
    });
  }).then(function(urls) {
    return new Set(urls);
  });
}

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(cacheName).then(function(cache) {
      return setOfCachedUrls(cache).then(function(cachedUrls) {
        return Promise.all(
          Array.from(urlsToCacheKeys.values()).map(function(cacheKey) {
            // If we don't have a key matching url in the cache already, add it.
            if (!cachedUrls.has(cacheKey)) {
              var request = new Request(cacheKey, {credentials: 'same-origin'});
              return fetch(request).then(function(response) {
                // Bail out of installation unless we get back a 200 OK for
                // every request.
                if (!response.ok) {
                  throw new Error('Request for ' + cacheKey + ' returned a ' +
                    'response with status ' + response.status);
                }

                return cleanResponse(response).then(function(responseToCache) {
                  return cache.put(cacheKey, responseToCache);
                });
              });
            }
          })
        );
      });
    }).then(function() {
      
      // Force the SW to transition from installing -> active state
      return self.skipWaiting();
      
    })
  );
});

self.addEventListener('activate', function(event) {
  var setOfExpectedUrls = new Set(urlsToCacheKeys.values());

  event.waitUntil(
    caches.open(cacheName).then(function(cache) {
      return cache.keys().then(function(existingRequests) {
        return Promise.all(
          existingRequests.map(function(existingRequest) {
            if (!setOfExpectedUrls.has(existingRequest.url)) {
              return cache.delete(existingRequest);
            }
          })
        );
      });
    }).then(function() {
      
      return self.clients.claim();
      
    })
  );
});


self.addEventListener('fetch', function(event) {
  if (event.request.method === 'GET') {
    // Should we call event.respondWith() inside this fetch event handler?
    // This needs to be determined synchronously, which will give other fetch
    // handlers a chance to handle the request if need be.
    var shouldRespond;

    // First, remove all the ignored parameters and hash fragment, and see if we
    // have that URL in our cache. If so, great! shouldRespond will be true.
    var url = stripIgnoredUrlParameters(event.request.url, ignoreUrlParametersMatching);
    shouldRespond = urlsToCacheKeys.has(url);

    // If shouldRespond is false, check again, this time with 'index.html'
    // (or whatever the directoryIndex option is set to) at the end.
    var directoryIndex = 'index.html';
    if (!shouldRespond && directoryIndex) {
      url = addDirectoryIndex(url, directoryIndex);
      shouldRespond = urlsToCacheKeys.has(url);
    }

    // If shouldRespond is still false, check to see if this is a navigation
    // request, and if so, whether the URL matches navigateFallbackWhitelist.
    var navigateFallback = '';
    if (!shouldRespond &&
        navigateFallback &&
        (event.request.mode === 'navigate') &&
        isPathWhitelisted([], event.request.url)) {
      url = new URL(navigateFallback, self.location).toString();
      shouldRespond = urlsToCacheKeys.has(url);
    }

    // If shouldRespond was set to true at any point, then call
    // event.respondWith(), using the appropriate cache key.
    if (shouldRespond) {
      event.respondWith(
        caches.open(cacheName).then(function(cache) {
          return cache.match(urlsToCacheKeys.get(url)).then(function(response) {
            if (response) {
              return response;
            }
            throw Error('The cached response that was expected is missing.');
          });
        }).catch(function(e) {
          // Fall back to just fetch()ing the request if some unexpected error
          // prevented the cached response from being valid.
          console.warn('Couldn\'t serve response for "%s" from cache: %O', event.request.url, e);
          return fetch(event.request);
        })
      );
    }
  }
});








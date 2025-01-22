function shareMastodon(e, text) {
  e.preventDefault();
  const instance = prompt("Enter your Mastodon instance:", "mastodon.social");
  if (instance) {
    const shareText = text;
    const shareUrl = `https://${instance}/share?text=${encodeURIComponent(shareText)}`;
    window.open(shareUrl, '_blank');
  }
}

function openChat() {
  let mobile = document.getElementById('mobile').value;
  document.getElementById("mobile").value = '';
  mobile = mobile.replace(/^\+/, '');
  window.open('https://api.whatsapp.com/send?phone=' + mobile, "_blank");
}

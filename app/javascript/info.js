function copyUrl () {
  const copyBtnGuest = document.getElementById("copy_btn_guest");
  copyBtnGuest.addEventListener('click', () => {
    const urlGuest = document.getElementById('url_guest');
    const urlGuestText = urlGuest.textContent.trim();
    // ブラウザがClipboard APIに対応しているか判定
    if (navigator.clipboard != undefined) {
      // 対応している場合
      navigator.clipboard.writeText(urlGuestText);
    } else {
      // 対応していない場合(IE)
      window.clipboardData.setData('Text', urlGuestText);
    }
  });
}

if (document.URL.match(/\/hosts\/.*\/info/)) {
  window.addEventListener('load', copyUrl());
}

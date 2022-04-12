// 要改修 2022.04.12 t.sema
// 重複部をfunctionにまとめるとwriteTextのpermissionを要求される
// firefoxがPermission APIに対応していない

function copyUrl () {
  const copyBtnGuest = document.getElementById("copy_btn_guest");
  const copyBtnHost  = document.getElementById("copy_btn_host");
  copyBtnGuest.addEventListener('click', () => {
    const url = document.getElementById('url_guest');
    const urlText = url.textContent.trim();
    // ブラウザがClipboard APIに対応しているか判定
    if (navigator.clipboard != undefined) {
      // 対応している場合
      navigator.clipboard.writeText(urlText);
    } else {
      // 対応していない場合(IE)
      window.clipboardData.setData('Text', urlText);
    }
  });
  copyBtnHost.addEventListener('click', () => {
    const url = document.getElementById('url_host');
    const urlText = url.textContent.trim();
    // ブラウザがClipboard APIに対応しているか判定
    if (navigator.clipboard != undefined) {
      // 対応している場合
      navigator.clipboard.writeText(urlText);
    } else {
      // 対応していない場合(IE)
      window.clipboardData.setData('Text', urlText);
    }
  });
}

window.addEventListener('load', copyUrl());

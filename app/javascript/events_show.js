const classHidden   = 'visually-hidden';
const classUnhidden = 'mt-0';

// イベント名の編集
const titleId = 'title';

const openEditTitleId   = 'open_edit_title';
const formEditTitleId   = 'form_edit_title';
const submitEditTitleId = 'submit_edit_title';
const noticeEditTitleId = 'notice_edit_title';

function formMain() {
  // イベント名の編集
  const openEditTitle   = document.getElementById(openEditTitleId);
  const formEditTitle   = document.getElementById(formEditTitleId);
  const submitEditTitle = document.getElementById(submitEditTitleId);
  let flagEditTitle = false;
  openEditTitle.addEventListener('click', () => { flagEditTitle = formOpen(formEditTitle, flagEditTitle) });
  submitEditTitle.addEventListener('click', (e) => { submitForm(e, formEditTitle) });
}

function formOpen(form, flag) {
  const formClass = form.classList;
  if (flag) {
    formClass.replace(classUnhidden, classHidden);
  } else {
    formClass.replace(classHidden, classUnhidden);
  }
  return !flag;
}

function submitForm(e, form) {
  e.preventDefault();
  const formData = new FormData(form);
  const token = document.getElementsByName('csrf-token').item(0).content;
  const XHR = new XMLHttpRequest();
  XHR.open('PUT', location.pathname, true);
  XHR.responseType = 'json';
  XHR.setRequestHeader('X-CSRF-Token', token);
  XHR.send(formData);

  XHR.onload = () => {
    const item = XHR.response.item
    const message = XHR.response.message
    editHtml(item, message, form.id);
  }
}

function editHtml(item, message, formId) {
  switch (formId) {
    // イベント名の編集
    case formEditTitleId:
      if (message == '') {
        const title  = document.getElementById(titleId);
        title.textContent = item.title;
      }
      const notice = document.getElementById(noticeEditTitleId);
      notice.textContent = message;
      break;
  }
}

// ブラウザ別動作対応
const agent = window.navigator.userAgent.toLowerCase()
if (agent.indexOf('firefox') != -1) {
  // firefoxの場合
  formMain();
} else {
  window.addEventListener('load', formMain);
}

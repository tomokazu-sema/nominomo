import Form from 'form'

const classHidden   = 'visually-hidden';
const classUnhidden = 'nomi-dmy';

// イベント名の編集
const formTitleId        = 'form_title';
const openFormTitleId    = 'open_form_title';
const closeFormTitleId   = 'close_form_title';
const submitFormTitleId  = 'submit_form_title';
const messageFormTitleId = 'message_form_title';

const titleId = 'title';

// 開催場所の作成・編集
const formPlaceId        = 'form_place';
const openFormPlaceId    = 'open_form_place';
const closeFormPlaceId   = 'close_form_place';
const submitFormPlaceId  = 'submit_form_place'; 
const messageFormPlaceId = 'message_form_place';

function formMain() {
  // イベント名の編集
  const formTitle = new Form(formTitleId);
  formTitle.openFormId   = openFormTitleId;
  formTitle.closeFormId  = closeFormTitleId;
  formTitle.submitFormId = submitFormTitleId;
  formTitle.openForm.addEventListener('click', () => { formTitle.openClose() });
  formTitle.closeForm.addEventListener('click', () => { formTitle.close() });
  formTitle.submitForm.addEventListener('click', (e) => {
    formTitle.submit(e);
    formTitle.XHR.addEventListener('load', () => {
      formTitle.onload();
      editHtml(formTitle);
    });
  });
  // 開催場所の作成・編集
  const formPlace = new Form(formPlaceId);
  formPlace.openFormId   = openFormPlaceId;
  formPlace.closeFormId  = closeFormPlaceId;
  formPlace.submitFormId = submitFormPlaceId;
  formPlace.openForm.addEventListener('click', () => { formPlace.openClose() });
  formPlace.closeForm.addEventListener('click', () => { formPlace.close() });
  formPlace.submitForm.addEventListener('click', (e) => {
    formPlace.submit(e);
    formPlace.XHR.addEventListener('load', () => {
      formPlace.onload();
      editHtml(formPlace);
    });
  });
}

function editHtml(form) {
  switch (form.formId) {
    // イベント名の編集
    case formTitleId:
      if (form.messages.length == 0) {
        const title  = document.getElementById(titleId);
        title.textContent = form.model.title;
        deleteMessageList(messageFormTitleId);
      } else {
        insertMessageList(messageFormTitleId, form.messages);
      }
      break;
    // 開催場所の作成・編集
    case formPlaceId:
      if (form.messages.length == 0) {
        location.reload();
      } else {
        insertMessageList(messageFormPlaceId, form.messages);
      }
      break;
  }
}

function insertMessageList(messageId, messages) {
  const message = document.getElementById(messageId);
  for (let i = 0; i < messages.length; i++) {
    const html = `<li>${messages[i]}</li>`;
    message.insertAdjacentHTML('beforeend', html);
  }
}

function deleteMessageList(messageId) {
  const message = document.getElementById(messageId);
  message.innerHTML = ``;
}

function replaceStringWithBr(element, str) {
  let index
  str = str.replace(/\r?\n/g, '<br>');
  element.innerHTML = ``;
  while (str != '') {
    index = str.indexOf('<br>');
    if (index != -1) {
      if (index > 0) element.insertAdjacentText('beforeend', str.slice(0, index));
      element.insertAdjacentHTML('beforeend', `<br>`);
      str = str.slice(index + 4);
    } else {
      if (str != '') element.insertAdjacentText('beforeend', str);
      str = '';
    }
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

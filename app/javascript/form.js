// class for 'events_show.js'
class Form {

  constructor(id) {
    this.formId = id;
    this.form   = document.getElementById(id);
    this.init();
  }

  init() {
    this.flagOpenForm = false;
    this.classHidden = 'visually-hidden';
    this.classUnhidden = 'nomi-form-dmy';
  }

  set openFormId(id) {
    this.openFromId = id;
    this.openForm   = document.getElementById(id);
  }

  set closeFormId(id) {
    this.closeFromId = id;
    this.closeForm   = document.getElementById(id);
  }

  set submitFormId(id) {
    this.submitFromId = id;
    this.submitForm   = document.getElementById(id);
  }

  open() {
    if (!this.flagOpenForm) this.form.classList.replace(this.classHidden, this.classUnhidden);
    this.flagOpenForm = true;
  }

  close() {
    if (this.flagOpenForm) this.form.classList.replace(this.classUnhidden, this.classHidden);
    this.flagOpenForm = false;
  }

  openClose() {
    if (this.flagOpenForm) {
      this.form.classList.replace(this.classUnhidden, this.classHidden);
    } else {
      this.form.classList.replace(this.classHidden, this.classUnhidden);
    }
    this.flagOpenForm = !this.flagOpenForm;
  }

  submit(e) {
    e.preventDefault();
    const formData = new FormData(this.form);
    const token = document.getElementsByName('csrf-token').item(0).content;
    this.XHR = new XMLHttpRequest();
    this.XHR.open(this.form.getAttribute('data-turbo-method').toUpperCase(), location.pathname, true);
    this.XHR.responseType = 'json';
    this.XHR.setRequestHeader('X-CSRF-Token', token);
    this.XHR.send(formData);
  }

  onload() {
    this.model = this.XHR.response.model
    this.messages = this.XHR.response.messages
  }

}

export default Form;

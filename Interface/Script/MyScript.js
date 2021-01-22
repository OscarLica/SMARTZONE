function ModalFunction(idContainer) {
    const Modal = document.getElementById(idContainer);
    if (Modal.style.display == "block") {
        Modal.style.transition = "all 1s";
        Modal.style.opacity = 0;
        setTimeout(1000, Modal.style.display = "none");
        //    () > {
        //        Modal.style.display = "none";
        //    }, 1000
        //);
    }
    else {
        Modal.style.transition = "all 1s";
        Modal.style.display = "block";
        setTimeout(100, Modal.style.opacity = 1);
        //    (ModalFunction) > {
        //        Modal.style.opacity = 1;
        //    }, 100
        //);
    }
}

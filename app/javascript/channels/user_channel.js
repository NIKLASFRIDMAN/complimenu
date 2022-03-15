import consumer from "./consumer"

const initUserCable = () => {
  const navbarContainer = document.querySelector(".navbar-container")

  if (navbarContainer) {
    const id = navbarContainer.dataset.userId;
    consumer.subscriptions.create({channel: "TableroomChannel", table_id: id}, {
      received(data) {
        console.log(data)
        navbarContainer.outerHTML = data
      }
    })
  }
}

export {initUserCable} ;

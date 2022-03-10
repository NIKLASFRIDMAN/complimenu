import "jquery-bar-rating";

// import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $('.submitstar').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };

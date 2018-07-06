import { stopPreviousAnimation } from './animate.js';
import { stopPreviousTimedAnimation } from './timedAnimate.js';

export function stopAnimations() {
    stopPreviousAnimation();
    stopPreviousTimedAnimation();
}
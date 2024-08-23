import { createApp } from 'vue/dist/vue.esm-bundler';
import router from './router'
import App from '../components/App.vue';

const app = createApp(App)
  .use(router)
  .mount('#app');

console.log("app", app);

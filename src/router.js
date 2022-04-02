import Vue from 'vue'
import Router from 'vue-router'
import App from './MainPage.vue'
import Login from "@/components/authentication/Login";
import {getAuth} from "firebase/auth";

Vue.use(Router)

const routes = [
    {
        path: '/',
        name: 'App',
        component: App,
        meta: {
            requiresAuth: false
        }
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    }
]

const router = new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

router.beforeEach((to, from, next) => {
    const auth = getAuth();
    const currentUser = auth.currentUser;
    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);

    if (requiresAuth && !currentUser)
        next('login');
    else
        next();
});

export default router
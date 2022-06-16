import axiosClient from "./axiosClient";

const userService = {
    // api login
    authenticate: (params) => {
        const url = "/user/login";
        return axiosClient.post(url, params);
    }
};

export default userService;
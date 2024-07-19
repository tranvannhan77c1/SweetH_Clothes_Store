window.onload=function() { 
	const form = document.getElementById("register_form");
    form.addEventListener("submit", (e) => {
        e.preventDefault();
        const input_address = document.getElementById("address");
        const input_phone = document.getElementById("phone");
        const input_username = document.getElementById("username");
        const input_fullname = document.getElementById("fullname");
        const input_email = document.getElementById("email");
        const input_password = document.getElementById("password");
        const input_confirmPassword = document.getElementById("confirmPassword");
    
        const _err = document.getElementById("error");
        _err.classList.remove("active");
    
        const _success = document.getElementById("success");
        _success.classList.remove("active");
    
        console.log("pass; " + input_password.value + " --- confirm: " + input_confirmPassword.value)
        if (validateEmail(input_email.value)) {
            if (input_username.value && input_password.value) {
                if (input_password.value === input_confirmPassword.value) {
                    const user = {
                        username: input_username.value,
                        email: input_email.value,
                        password: input_password.value,
                        fullName: input_fullname.value || "",
                        phone: input_phone.value || "",
                        address: input_address.value || "",
                        role: "Customer"
                    }
    
                    const data = JSON.stringify(user);
                    console.log("data sent to server: ", data)
                    fetch("http://localhost:8080/api/v1/auth/signup", {
                        method: "POST",
                        body: data,
                        headers: {
                            "Content-Type": "application/json"
                        }
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Error ' + response.statusText);
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Success:', data);
                            _success.classList.add("active");
                            _success.textContent = "Đăng ký thành công !!!"
                            window.location.href = "login.html";
                        })
                        .catch(error => {
                            console.error('There was a problem with your fetch operation:', error);
                            _err.classList.add("active");
                            _err.textContent = "Lỗi đăng ký !!!";
                        });
                } else {
                    _err.classList.add("active");
                    _err.textContent = "Xác nhận mật khẩu không chính xác !!!";
                }
            } else {
                _err.classList.add("active");
                _err.textContent = "Tài khoản và mật khẩu không được để trống !!!";
            }
        } else {
            _err.classList.add("active");
            _err.textContent = "Email không đúng !!!";
        }
    
    })
 }


const validateEmail = (email) => {
    return String(email)
        .toLowerCase()
        .match(
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        );
};

const validPhoneNumber = (phoneNumber) => {
    const regexPhoneNumber = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;

    return phoneNumber.match(regexPhoneNumber);
}

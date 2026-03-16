<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thất bại</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .payment-card {
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
            max-width: 450px;
            width: 90%;
        }
        .icon-fail {
            color: #dc3545; /* Màu đỏ báo lỗi */
            margin-bottom: 20px;
        }
        .btn-custom {
            width: 100%;
            margin-top: 12px;
            padding: 10px;
            font-weight: 500;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-card {
            animation: fadeInUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) both;
        }
    </style>
</head>
<body>

    <div class="payment-card animate-card">
        <div class="icon-fail">
            <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" viewBox="0 0 16 16">
              <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z"/>
            </svg>
        </div>
        
        <h3 class="mb-3 text-danger">Thanh Toán Thất Bại!</h3>
        <p class="text-muted mb-4">
            Rất tiếc, giao dịch mua khóa học của bạn không thể hoàn tất. Nguyên nhân có thể do bạn đã hủy giao dịch, thẻ không đủ số dư hoặc lỗi từ phía ngân hàng.
        </p>
        
        <hr class="my-4 text-muted">
        
        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-danger btn-custom">
            Thử thanh toán lại
        </a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-custom">
            Quay về Trang chủ
        </a>
    </div>

</body>
</html>
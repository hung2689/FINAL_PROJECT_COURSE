<%-- Document : roadmap Created on : Mar 5, 2026 Author : ADMIN --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Roadmap | DevLearn</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">

    <style>
        /* ============================================================
           RESET
        ============================================================ */
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html { scroll-behavior: smooth; }

        /* ============================================================
           DESIGN TOKENS
        ============================================================ */
        :root {
            --bg: #182b29;
            --bg-deep: #111f1d;
            --bg-card: #1f3532;
            --bg-card2: #243d39;
            --mint: #5ef6a5;
            --mint-dim: rgba(94, 246, 165, 0.12);
            --mint-border: rgba(94, 246, 165, 0.25);
            --white: #ffffff;
            --off-white: rgba(255, 255, 255, 0.85);
            --text-muted: rgba(255, 255, 255, 0.45);
            --text-dim: rgba(255, 255, 255, 0.28);
            --border: rgba(255, 255, 255, 0.08);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.35);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg);
            color: var(--off-white);
            min-height: 100vh;
            padding-top: 68px;
        }

        /* ============================================================
           HEADER
        ============================================================ */
        .hdr {
            position: fixed; inset: 0 0 auto 0; z-index: 900;
            height: 68px; background: var(--bg-deep);
            border-bottom: 1px solid var(--border);
            display: flex; align-items: center;
        }

        .hdr-inner {
            max-width: 1340px; width: 100%; margin: 0 auto;
            padding: 0 28px; display: flex; align-items: center; gap: 20px;
        }

        .hdr-logo { display: flex; align-items: center; gap: 9px; text-decoration: none; flex-shrink: 0; }
        .hdr-logo-box {
            width: 36px; height: 36px; border-radius: 9px;
            background: var(--mint); display: flex; align-items: center; justify-content: center;
        }
        .hdr-logo-box .material-symbols-outlined { font-size: 20px; color: #071a0f; font-variation-settings: 'wght' 700; }
        .hdr-logo-text { font-size: 19px; font-weight: 800; color: var(--white); }

        .hdr-search { position: relative; flex-shrink: 0; }
        .hdr-search input {
            width: 180px; padding: 7px 14px 7px 36px; border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.14); background: rgba(255, 255, 255, 0.06);
            color: var(--off-white); font-size: 13.5px; outline: none; transition: 0.2s;
        }
        .hdr-search input::placeholder { color: var(--text-muted); }
        .hdr-search input:focus { border-color: var(--mint-border); background: rgba(94, 246, 165, 0.06); }
        .hdr-search .s-icon { position: absolute; left: 11px; top: 50%; transform: translateY(-50%); font-size: 17px; color: var(--text-muted); pointer-events: none; }

        .hdr-nav { display: flex; align-items: center; gap: 2px; flex: 1; justify-content: center; }
        .hdr-nav a { font-size: 14px; font-weight: 500; color: var(--text-muted); text-decoration: none; padding: 7px 12px; border-radius: 7px; transition: 0.2s; }
        .hdr-nav a:hover, .hdr-nav a.active { color: var(--white); }
        .hdr-nav a.active { color: var(--mint); }

        .hdr-right { display: flex; align-items: center; gap: 12px; flex-shrink: 0; }
        .cart-btn {
            position: relative; width: 40px; height: 40px; border-radius: 50%;
            border: 1px solid rgba(255, 255, 255, 0.12); background: rgba(255, 255, 255, 0.05);
            display: flex; align-items: center; justify-content: center; color: var(--off-white); transition: 0.2s;
        }
        .cart-btn:hover { border-color: var(--mint-border); color: var(--mint); }
        .cart-btn .material-symbols-outlined { font-size: 20px; }
        .cart-dot { position: absolute; top: 1px; right: 1px; width: 10px; height: 10px; border-radius: 50%; background: var(--mint); border: 2px solid var(--bg-deep); }

        /* ============================================================
           PAGE WRAPPER
        ============================================================ */
        .page-wrap { max-width: 1340px; margin: 0 auto; padding: 0 24px; }

        /* --- ACTION BAR --- */
        .top-action-bar {
            padding: 24px 0 0 0;
            display: flex;
            justify-content: flex-start;
        }
        .btn-edit-info {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(255,255,255,0.05); border: 1px solid var(--border);
            color: var(--off-white); padding: 8px 16px; border-radius: 8px;
            font-size: 13.5px; font-weight: 500; text-decoration: none;
            transition: all 0.2s ease;
        }
        .btn-edit-info:hover {
            background: var(--mint-dim); border-color: var(--mint-border); color: var(--mint);
        }
        .btn-edit-info .material-symbols-outlined { font-size: 18px; }

        /* ============================================================
           TOP HERO 
        ============================================================ */
        .hero { text-align: center; padding: 32px 20px 40px; }
        .hero-eyebrow {
            display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 700;
            letter-spacing: 1.5px; text-transform: uppercase; color: var(--mint); padding: 5px 14px;
            border: 1px solid var(--mint-border); border-radius: 999px; background: var(--mint-dim); margin-bottom: 20px;
        }
        .hero h1 { font-family: 'Space Grotesk', 'Inter', sans-serif; font-size: clamp(24px, 4vw, 44px); font-weight: 800; color: var(--white); line-height: 1.15; text-transform: uppercase; margin-bottom: 40px; }
        .hero h1 .hi { color: var(--mint); }

        .stats-row { display: flex; justify-content: center; gap: 16px; flex-wrap: wrap; margin-bottom: 56px; }
        .stat-card {
            background: var(--bg-card); border: 1px solid var(--border); border-radius: 16px;
            padding: 20px 28px; min-width: 148px; text-align: center; position: relative; overflow: hidden; transition: 0.3s;
        }
        .stat-card:hover { border-color: var(--mint-border); transform: translateY(-3px); }
        .stat-icon { font-size: 22px; margin-bottom: 8px; }
        .stat-val { font-family: 'Space Grotesk', sans-serif; font-size: 26px; font-weight: 700; color: var(--white); }
        .stat-val span { color: var(--mint); }
        .stat-lbl { font-size: 11.5px; color: var(--text-muted); font-weight: 500; text-transform: uppercase; letter-spacing: 0.8px; margin-top: 4px; }

        .ring-wrap { position: relative; width: 56px; height: 56px; margin: 0 auto 6px; }
        .ring-wrap svg { transform: rotate(-90deg); }
        .ring-bg { stroke: rgba(255, 255, 255, 0.08); }
        .ring-fill { stroke: var(--mint); stroke-linecap: round; stroke-dasharray: 157; stroke-dashoffset: 157; transition: stroke-dashoffset 1.4s ease; }
        .ring-label { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: 700; color: var(--mint); }

        /* ============================================================
           MAIN CONTENT
        ============================================================ */
        .main-grid { display: grid; grid-template-columns: 260px 1fr 280px; gap: 28px; align-items: start; padding-bottom: 60px;}

        /* LEFT COL */
        .left-col { display: flex; flex-direction: column; gap: 20px; }
        .skills-block, .info-block { background: var(--bg-card); border: 1px solid var(--border); border-radius: 18px; padding: 22px; }
        .block-title { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.8px; color: var(--mint); margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
        .block-title::before { content: ''; display: inline-block; width: 3px; height: 14px; background: var(--mint); border-radius: 999px; }
        .skill-tags { display: flex; flex-wrap: wrap; gap: 8px; }
        .stag { display: inline-flex; align-items: center; gap: 5px; padding: 5px 13px; border-radius: 999px; border: 1px solid var(--mint-border); background: var(--mint-dim); color: var(--mint); font-size: 12px; font-weight: 600; cursor: default; transition: 0.2s; }
        .stag:hover { background: rgba(94, 246, 165, 0.2); transform: translateY(-1px); }

        .info-row { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
        .info-row:last-child { margin-bottom: 0; }
        .info-icon { width: 34px; height: 34px; border-radius: 9px; background: var(--mint-dim); border: 1px solid var(--mint-border); display: flex; align-items: center; justify-content: center; font-size: 16px; flex-shrink: 0; }
        .info-text strong { display: block; font-size: 14px; font-weight: 700; color: var(--white); line-height: 1.2; }
        .info-text span { font-size: 11.5px; color: var(--text-muted); }

        /* MIDDLE COL */
        .section-eyebrow { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.8px; color: var(--mint); text-align: center; margin-bottom: 32px; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .section-eyebrow::before, .section-eyebrow::after { content: ''; flex: 1; max-width: 60px; height: 1px; background: var(--mint-border); }

        .timeline { position: relative; padding-bottom: 20px; }
        .timeline::before { content: ''; position: absolute; left: 50%; transform: translateX(-50%); top: 0; bottom: 0; width: 2px; background: linear-gradient(180deg, var(--mint) 0%, rgba(94, 246, 165, 0.15) 100%); z-index: 0; }
        .tli { display: flex; justify-content: flex-end; padding-right: calc(50% + 32px); margin-bottom: 36px; position: relative; opacity: 0; transform: translateX(-24px); transition: opacity 0.5s ease, transform 0.5s ease; }
        .tli.r { justify-content: flex-start; padding-right: 0; padding-left: calc(50% + 32px); transform: translateX(24px); }
        .tli.visible { opacity: 1; transform: translateX(0); }
        .tli::after { content: ''; position: absolute; left: 50%; top: 24px; transform: translateX(-50%); width: 14px; height: 14px; border-radius: 50%; background: var(--bg); border: 2.5px solid var(--mint); z-index: 2; transition: all 0.25s ease; box-shadow: 0 0 10px rgba(94, 246, 165, 0.4); }
        .tli:hover::after { background: var(--mint); box-shadow: 0 0 18px rgba(94, 246, 165, 0.7); transform: translateX(-50%) scale(1.3); }
        .tli-num { position: absolute; left: 50%; top: -10px; transform: translateX(-50%); background: var(--mint); color: #071a0f; font-size: 9.5px; font-weight: 800; width: 20px; height: 20px; border-radius: 50%; display: flex; align-items: center; justify-content: center; z-index: 3; }

        .ccard { background: var(--white); border-radius: 16px; padding: 20px; width: 100%; max-width: 380px; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.25); transition: 0.3s; }
        .ccard:hover { transform: translateY(-4px); box-shadow: 0 0 0 2px var(--mint), 0 12px 36px rgba(0, 0, 0, 0.3); }
        .ccard-top { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 10px; }
        .ccard-ico { width: 40px; height: 40px; border-radius: 10px; background: #f0fdf4; border: 1.5px solid #d1fae5; display: flex; align-items: center; justify-content: center; font-size: 19px; flex-shrink: 0; }
        .ccard-title { font-size: 13.5px; font-weight: 800; color: #0f172a; text-transform: uppercase; margin-bottom: 2px; }
        .ccard-sub { font-size: 11px; color: #64748b; font-weight: 500; }
        .ccard-desc { font-size: 12.5px; color: #475569; line-height: 1.65; margin-bottom: 14px; }
        
        .ccard-prog { margin-bottom: 14px; }
        .ccard-prog-top { display: flex; justify-content: space-between; font-size: 10.5px; color: #94a3b8; margin-bottom: 5px; font-weight: 600; }
        .ccard-prog-bar { height: 4px; background: #e2e8f0; border-radius: 999px; overflow: hidden; }
        .ccard-prog-fill { height: 100%; border-radius: 999px; background: linear-gradient(90deg, #10b981, #5ef6a5); transition: width 1.1s ease; }
        
        .ccard-details { display: none; font-size: 12px; color: #475569; line-height: 1.7; margin-bottom: 12px; padding: 10px 12px; background: #f8fafc; border-radius: 8px; border-left: 3px solid #10b981; }
        .ccard-details ul { list-style: none; }
        .ccard-details li { display: flex; align-items: flex-start; gap: 7px; padding: 2px 0; }
        .ccard-details li::before { content: '✓'; color: #10b981; font-weight: 700; font-size: 11px; margin-top: 1px; }
        
        .ccard-toggle { display: inline-flex; align-items: center; gap: 4px; font-size: 12px; font-weight: 600; color: #2563eb; background: none; border: none; cursor: pointer; padding: 0; margin-bottom: 12px; }
        .ccard-toggle .arr { transition: transform 0.3s; font-size: 10px; }
        .ccard-toggle.open .arr { transform: rotate(180deg); }
        .ccard-foot { border-top: 1px solid #e2e8f0; padding-top: 12px; }
        
        .btn-mint { display: inline-flex; align-items: center; justify-content: center; gap: 6px; width: 100%; padding: 10px 18px; border-radius: 9px; font-size: 13px; font-weight: 700; background: var(--mint); color: #071a0f; border: none; cursor: pointer; text-decoration: none; text-transform: uppercase; transition: 0.25s; }
        .btn-mint:hover { background: #7ffab8; box-shadow: 0 4px 18px rgba(94, 246, 165, 0.45); transform: translateY(-1px); }
        .btn-coming { display: inline-flex; align-items: center; justify-content: center; gap: 6px; width: 100%; padding: 10px 18px; border-radius: 9px; font-size: 13px; font-weight: 600; background: #f1f5f9; color: #94a3b8; border: 1.5px solid #e2e8f0; cursor: not-allowed; text-transform: uppercase; }

        .tl-more { text-align: center; padding-top: 8px; }
        .btn-view-more { display: inline-flex; align-items: center; gap: 6px; padding: 11px 28px; border-radius: 10px; background: var(--white); color: #0f172a; font-size: 13.5px; font-weight: 700; border: none; cursor: pointer; text-transform: uppercase; transition: 0.25s; }
        .btn-view-more:hover { background: var(--mint); color: #071a0f; }

        /* RIGHT COL */
        .right-col { position: sticky; top: 88px; }
        .cta-block { background: var(--bg-card); border: 1px solid var(--border); border-radius: 20px; padding: 32px 24px; text-align: center; position: relative; overflow: hidden; }
        .cta-block::before { content: ''; position: absolute; top: -60px; right: -60px; width: 200px; height: 200px; border-radius: 50%; background: radial-gradient(circle, rgba(94, 246, 165, 0.12) 0%, transparent 70%); pointer-events: none; }
        .cta-emoji { font-size: 40px; display: block; margin-bottom: 14px; }
        .cta-block h2 { font-family: 'Space Grotesk', sans-serif; font-size: 22px; font-weight: 800; color: var(--white); text-transform: uppercase; line-height: 1.25; margin-bottom: 12px; position: relative; z-index: 1; }
        .cta-block p { font-size: 13.5px; color: var(--text-muted); line-height: 1.7; margin-bottom: 22px; position: relative; z-index: 1; }
        .btn-cta { display: inline-flex; align-items: center; justify-content: center; gap: 8px; width: 100%; padding: 14px 20px; background: var(--mint); color: #071a0f; border-radius: 12px; font-size: 14px; font-weight: 800; border: none; cursor: pointer; text-decoration: none; text-transform: uppercase; transition: 0.3s; position: relative; z-index: 1; }
        .btn-cta:hover { background: #7ffab8; transform: translateY(-2px); box-shadow: 0 8px 28px rgba(94, 246, 165, 0.45); }
        .cta-divider { border: none; border-top: 1px solid var(--border); margin: 22px 0; }
        .cta-mini-stat { display: flex; justify-content: space-between; font-size: 12px; color: var(--text-muted); margin-bottom: 8px; }
        .cta-mini-stat strong { color: var(--mint); font-weight: 700; }

        /* ============================================================
           BANNER 
        ============================================================ */
        .breakthrough-banner {
            max-width: 1340px; margin: 0 auto 60px; padding: 0 24px;
        }
        .banner-inner {
            background: linear-gradient(135deg, var(--bg-card2), var(--bg-deep));
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 60px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow);
        }
        .banner-inner::after {
            content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0;
            background-image: radial-gradient(var(--border) 1px, transparent 1px);
            background-size: 30px 30px; opacity: 0.3; pointer-events: none;
        }
        .banner-inner h2 {
            font-family: 'Space Grotesk', sans-serif; font-size: 32px; font-weight: 800;
            color: var(--white); margin-bottom: 16px; position: relative; z-index: 1;
        }
        .banner-inner p {
            font-size: 15px; color: var(--text-muted); margin-bottom: 30px;
            max-width: 600px; margin-inline: auto; position: relative; z-index: 1;
        }
        .banner-inner .btn-large {
            display: inline-flex; padding: 14px 36px; background: var(--mint); color: #071a0f;
            border-radius: 999px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px;
            text-decoration: none; position: relative; z-index: 1; transition: 0.3s;
            box-shadow: 0 8px 24px rgba(94, 246, 165, 0.2);
        }
        .banner-inner .btn-large:hover {
            transform: translateY(-3px); box-shadow: 0 12px 32px rgba(94, 246, 165, 0.4); background: #7ffab8;
        }

        /* ============================================================
           FOOTER
        ============================================================ */
        .site-footer {
            background: var(--bg-deep);
            border-top: 1px solid var(--border);
            padding: 60px 24px 40px;
        }
        .footer-grid {
            max-width: 1340px; margin: 0 auto;
            display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px; margin-bottom: 60px;
        }
        .ft-col h3 {
            font-size: 14px; font-weight: 700; color: var(--white);
            margin-bottom: 20px; padding-bottom: 12px; border-bottom: 1px solid var(--border);
        }
        .ft-col ul { list-style: none; }
        .ft-col ul li { margin-bottom: 12px; }
        .ft-col ul li a {
            color: var(--text-muted); text-decoration: none; font-size: 13.5px; transition: 0.2s;
        }
        .ft-col ul li a:hover { color: var(--mint); }
        .ft-col p { font-size: 13px; color: var(--text-muted); margin-bottom: 8px; line-height: 1.5; }

        .footer-bottom {
            max-width: 1340px; margin: 0 auto;
            border-top: 1px solid var(--border); padding-top: 30px;
            display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 20px;
        }
        .ft-logo-area { display: flex; flex-direction: column; gap: 12px;}
        .ft-logo-area .hdr-logo-text { color: var(--mint); font-size: 24px;}
        .ft-logo-desc { font-size: 13px; color: var(--text-muted);}
        
        .ft-socials { display: flex; gap: 16px; }
        .ft-socials a {
            width: 36px; height: 36px; border-radius: 50%; background: rgba(255,255,255,0.05);
            display: flex; align-items: center; justify-content: center;
            color: var(--white); text-decoration: none; transition: 0.3s;
        }
        .ft-socials a:hover { background: var(--mint); color: #071a0f; transform: translateY(-3px);}
        .ft-copyright { width: 100%; text-align: left; font-size: 12px; color: var(--text-dim); margin-top: 10px;}

        /* ============================================================
           FLOATING USER WIDGET
        ============================================================ */
        .user-float { position: fixed; bottom: 20px; left: 20px; z-index: 1000; }
        
        .user-pill {
            position: relative; z-index: 1; display: inline-flex; align-items: center; gap: 12px;
            padding: 6px 16px 6px 6px; 
            background: rgba(40, 48, 46, 0.85); 
            backdrop-filter: blur(10px);
            border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.1);
            cursor: pointer; font-family: 'Inter', sans-serif;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.3); transition: all 0.2s;
        }
        .user-pill:hover { background: rgba(60, 70, 68, 0.9); border-color: rgba(255, 255, 255, 0.2); transform: translateY(-2px); }
        .user-pill.open { background: rgba(60, 70, 68, 0.9); border-color: var(--mint-border); }

        .user-av-wrap { position: relative; flex-shrink: 0; }
        .user-av {
            width: 34px; height: 34px; border-radius: 50%;
            background: #65a30d; 
            display: flex; align-items: center; justify-content: center;
            font-size: 15px; font-weight: 700; color: var(--white); overflow: hidden;
            border: 2px solid transparent;
        }
        .user-av img { width: 100%; height: 100%; object-fit: cover; }

        .user-text { text-align: left; line-height: 1.2; display: flex; flex-direction: column; justify-content: center; padding-right: 4px;}
        .user-name { display: block; font-size: 10px; color: var(--text-muted); font-weight: 500;}
        .user-email { display: block; font-size: 12px; color: var(--white); font-weight: 600; }

        .user-drop {
            display: none; position: absolute; bottom: calc(100% + 10px); left: 0;
            width: 220px; background: var(--bg-card); border: 1px solid var(--border);
            border-radius: 14px; overflow: hidden; box-shadow: var(--shadow);
        }
        .user-drop.open { display: block; }
        .dd-hdr { padding: 12px 16px; border-bottom: 1px solid var(--border); }
        .dd-hdr .dd-signed { font-size: 10.5px; color: var(--text-muted); margin-bottom: 2px; }
        .dd-hdr .dd-email { font-size: 12.5px; font-weight: 700; color: var(--mint); }
        .dd-row { display: flex; align-items: center; gap: 10px; padding: 10px 16px; font-size: 13px; color: var(--off-white); text-decoration: none; transition: 0.15s; }
        .dd-row:hover { background: rgba(255, 255, 255, 0.05); color: var(--mint); }
        .dd-row .material-symbols-outlined { font-size: 17px; }
        .dd-sep { border-top: 1px solid var(--border); }
        .dd-row.danger { color: #f87171; }
        .dd-row.danger:hover { background: rgba(248, 113, 113, 0.08); }

        /* ============================================================
           RESPONSIVE
        ============================================================ */
        @media (max-width: 1100px) { .main-grid { grid-template-columns: 220px 1fr 240px; gap: 20px; } }
        @media (max-width: 860px) {
            .main-grid { grid-template-columns: 1fr; }
            .right-col { position: static; }
            .tli, .tli.r { padding: 0 0 0 48px; justify-content: flex-start; }
            .tli::after { left: 16px; } .tli-num { left: 16px; } .timeline::before { left: 16px; }
            .ccard { max-width: 100%; }
            .hdr-nav a:nth-child(n+4) { display: none; }
        }
        @media (max-width: 580px) {
            .hdr-search { display: none; } .hdr-nav { display: none; }
            .stats-row { gap: 10px; } .stat-card { min-width: 130px; }
            .user-float { bottom: 14px; left: 14px; }
        }
        .btn-level-up {
    /* Hình dạng và Kích thước */
    display: inline-block;
    padding: 12px 30px; /* Điều chỉnh khoảng cách bên trong nút */
    border-radius: 50px; /* Tạo bo góc hình viên thuốc hoàn hảo */
    
    /* Màu sắc và Văn bản */
    background-color: #55f3a3; /* Màu xanh lá tươi chuẩn theo ảnh mẫu */
    color: #111; /* Màu chữ tối (đen hoặc xám đậm) */
    font-size: 16px; /* Kích thước chữ */
    font-weight: bold; /* Chữ in đậm */
    text-transform: uppercase; /* Chữ in hoa toàn bộ */
    text-decoration: none; /* Bỏ gạch chân nếu dùng thẻ <a> */
    border: none; /* Bỏ viền mặc định */
    cursor: pointer; /* Hiển thị con trỏ tay khi di chuột vào */

    /* Hiệu ứng đổ bóng và chuyển động */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3); /* Đổ bóng sâu tạo khối */
    transition: all 0.3s ease; /* Tạo hiệu ứng mượt mà khi di chuột vào */
}

/* Hiệu ứng khi di chuột vào (Hover) */
.btn-level-up:hover {
    box-shadow: 0 6px 10px rgba(0, 0, 0, 0.4); /* Bóng đậm và rộng hơn */
    transform: translateY(-2px); /* Nút "bay" nhẹ lên một chút */
    background-color: #44e292; /* Màu đậm hơn một chút khi hover */
    /* CSS dùng để ẩn các khóa học từ vị trí thứ 5 trở đi */
.hidden-timeline-item {
    display: none !important;
}
}
/* --- TARGET UI: NÚT PILL SÁNG MÀU GIỐNG HÌNH 1 --- */
.user-pill-light {
    position: relative; z-index: 1; display: inline-flex; align-items: center; gap: 10px;
    padding: 6px 14px 6px 6px; 
    background: #f8fafc; /* Nền xám nhạt */
    border-radius: 999px; border: 1px solid #e2e8f0;
    cursor: pointer; font-family: 'Inter', sans-serif;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); transition: all 0.2s;
}
.user-pill-light:hover { background: #f1f5f9; transform: translateY(-2px); }
.user-pill-light.open { background: #f1f5f9; box-shadow: 0 0 0 2px #10b981; }

.user-av-light {
    width: 36px; height: 36px; border-radius: 50%;
    background: #fed7aa; /* Nền dự phòng cho avatar */
    display: flex; align-items: center; justify-content: center;
    overflow: hidden; flex-shrink: 0; border: 1px solid #cbd5e1;
}
.user-av-light img { width: 100%; height: 100%; object-fit: cover; }

.user-text-light { text-align: left; line-height: 1.2; display: flex; flex-direction: column; justify-content: center; }
.user-name-light { font-size: 14px; color: #0f172a; font-weight: 700; letter-spacing: -0.2px;}
.user-role-light { font-size: 10px; color: #64748b; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-top: 2px;}

.user-arrow-light { font-size: 18px; color: #64748b; transition: transform 0.3s; margin-left: 4px;}
.user-pill-light.open .user-arrow-light { transform: rotate(180deg); }

/* --- TARGET UI: MENU DROPDOWN SÁNG MÀU GIỐNG HÌNH 1 --- */
.user-drop-light {
    display: none; position: absolute; bottom: calc(100% + 12px); left: 0;
    width: 240px; background: #ffffff; border: 1px solid #e2e8f0;
    border-radius: 16px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.12);
    transform-origin: bottom left;
}
.user-drop-light.open { display: block; animation: slideUp 0.2s ease; }
@keyframes slideUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

.dd-hdr-light { padding: 16px; border-bottom: 1px solid #f1f5f9; }
.dd-hdr-light .dd-signed { font-size: 13px; color: #475569; margin-bottom: 4px; font-weight: 500;}
.dd-hdr-light .dd-email { font-size: 14.5px; font-weight: 700; color: #10b981; word-break: break-all;} /* Màu xanh chuẩn */

.dd-row-light {
    display: flex; align-items: center; gap: 12px; padding: 12px 16px; 
    font-size: 14px; color: #334155; font-weight: 500; text-decoration: none; transition: 0.15s;
}
.dd-row-light:hover { background: #f8fafc; color: #0f172a; }
.dd-row-light .material-symbols-outlined { font-size: 20px; color: #475569; }

.dd-sep-light { height: 1px; background: #f1f5f9; margin: 4px 0; }

.dd-row-light.danger { color: #ef4444; }
.dd-row-light.danger .material-symbols-outlined { color: #ef4444; }
.dd-row-light.danger:hover { background: #fef2f2; color: #dc2626; }
    </style>
</head>

<body>
   

    <header class="hdr">
        <div class="hdr-inner">
            <a href="${pageContext.request.contextPath}/home" class="hdr-logo">
                <div class="hdr-logo-box"><span class="material-symbols-outlined">terminal</span></div>
                <span class="hdr-logo-text">DevLearn</span>
            </a>
            <div class="hdr-search">
                <span class="material-symbols-outlined s-icon">search</span>
                <input type="text" placeholder="Search">
            </div>
            <nav class="hdr-nav">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/shop">Courses</a>
                <a href="#" class="active">Learning Paths</a>
                <a href="#">Community</a>
                <a href="#">About Us</a>
            </nav>
            <div class="hdr-right">
                <a href="${pageContext.request.contextPath}/cart" class="cart-btn" title="Cart">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    <span class="cart-dot"></span>
                </a>
            </div>
        </div>
    </header>

    <div class="page-wrap">
        
        <div class="top-action-bar">
    <a href="${pageContext.request.contextPath}/learningpaths" class="btn-edit-info">
        <span class="material-symbols-outlined">arrow_back</span>
        Edit Profile
    </a>
 </div>
        <section class="hero">
            <div class="hero-eyebrow">✦ Personal Learning Roadmap</div>
          <h1>Roadmap to Master<br><span class="hi">${roadmapName}</span></h1>

            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon">📚</div>
                    <div class="stat-val"><span data-target="${totalCourses}">0</span></div>
                    <div class="stat-lbl">Subjects</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⚡</div>
                    <div class="stat-val"><span data-target="${totalCourses}">0</span></div>
                    <div class="stat-lbl">Skills</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🎓</div>
                    <div class="stat-val"><span data-target="${totalCourses}">0</span></div>
                    <div class="stat-lbl">Courses</div>
                </div>
                <div class="stat-card">
                    <div class="ring-wrap">
                        <svg width="56" height="56" viewBox="0 0 56 56">
                            <circle class="ring-bg" cx="28" cy="28" r="25" fill="none" stroke-width="5" />
                            <circle class="ring-fill" id="progressRing" cx="28" cy="28" r="25" fill="none" stroke-width="5" />
                        </svg>
                        <div class="ring-label" id="ringLabel">0%</div>
                    </div>
                    <div class="stat-lbl">Completed</div>
                </div>
            </div>
        </section>

        <div class="main-grid">

            <aside class="left-col">
                <div class="skills-block">
                    <div class="block-title">Current Skills</div>
                    <div class="skill-tags">
                        <span class="stag">Algorithms</span>
                        <span class="stag">Java</span>
                        <span class="stag">UML</span>
                        <span class="stag">Git</span>
                        <span class="stag">Java Web</span>
                        <span class="stag">Spring</span>
                        <span class="stag">Docker</span>
                        <span class="stag">SQL</span>
                        <span class="stag">REST API</span>
                        <span class="stag">CI/CD</span>
                    </div>
                </div>

                <div class="info-block">
                    <div class="block-title">Your Progress</div>
                    <div class="info-row">
                        <div class="info-icon">🏆</div>
                        <div class="info-text">
                            <strong>0 / 8 Completed</strong>
                            <span>Passed subjects</span>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-icon">🔥</div>
                        <div class="info-text">
                            <strong>14 Days</strong>
                            <span>Learning streak</span>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-icon">⭐</div>
                        <div class="info-text">
                            <strong>Premium</strong>
                            <span>Active member</span>
                        </div>
                    </div>
                </div>
            </aside>

         <main class="mid-col">
            <div class="section-eyebrow">Learning Journey</div>

            <div class="timeline">
                
    <%-- Lặp qua danh sách courseList lấy từ Servlet --%>
    <c:forEach items="${courseList}" var="course" varStatus="loop">
        
        <%-- Nếu là môn thứ 5 trở đi (index >= 4), thêm class 'hidden-timeline-item' để ẩn --%>
        <div class="tli ${loop.index % 2 != 0 ? 'r' : ''} ${loop.index >= 4 ? 'hidden-timeline-item' : ''}" data-index="${loop.index}">
            <span class="tli-num">${loop.index + 1}</span>
            <div class="ccard">
                <div class="ccard-top">
                    <div class="ccard-ico">💻</div> 
                    <div>
                        <div class="ccard-title">${course.title}</div>
                        <div class="ccard-sub">Level: ${course.level}</div>
                    </div>
                </div>
                
                <div class="ccard-prog">
                    <div class="ccard-prog-top"><span>Progress</span><span>0%</span></div>
                    <div class="ccard-prog-bar">
                        <div class="ccard-prog-fill" data-w="0%" style="width:0"></div>
                    </div>
                </div>
                
                <p class="ccard-desc">${course.description}</p>
                
                <button class="ccard-toggle" onclick="tog(this)">View More <span class="arr">▼</span></button>
                
                <div class="ccard-details">
                    <ul>
                        <li>Price: $${course.price}</li>
                    </ul>
                </div>
                
                <div class="ccard-foot">
                    <c:choose>
                        <c:when test="${course.status == 'ACTIVE'}">
                            <a href="${pageContext.request.contextPath}/shop" class="btn-mint">📚 Start Learning Now</a>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-coming" disabled>🔮 Coming Soon</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
    </c:forEach>
    
    <%-- NÚT VIEW MORE: Chỉ hiển thị nếu tổng số môn học lớn hơn 4 --%>
    <c:if test="${totalCourses > 4}">
        <div class="tl-more" id="viewMoreContainer">
            <button type="button" class="btn-view-more" onclick="showAllTimelineItems()">View More ↓</button>
        </div>
    </c:if>
</div>
        </main>

            <aside class="right-col">
    <div class="cta-block">
        <span class="cta-emoji">🚀</span>
        <h2>Ready to<br>Level Up?</h2>
        <p>Begin your journey to master technology today. One step each day — that's how professionals are made.</p>
        <a href="${pageContext.request.contextPath}/shop" style="text-decoration: none;">
            <button type="button" class="btn-level-up"> ⚡ START LEARNING NOW
            </button>
        </a>
        <hr class="cta-divider">
        
        <div class="cta-mini-stat"><span>Subjects</span><strong>${totalCourses}</strong></div>
        <div class="cta-mini-stat"><span>Completed</span><strong>${not empty completionPercent ? completionPercent : 0}%</strong></div>
        <div class="cta-mini-stat"><span>Available Now</span><strong>${totalCourses} Courses</strong></div>
        
    </div>
</aside>

        </div></div><section class="breakthrough-banner">
        <div class="banner-inner">
            <h2>Ready for a Breakthrough?</h2>
            <p>A journey of a thousand miles begins with a single step. Start with your first skill today.</p>
            <a href="${pageContext.request.contextPath}/shop" >
                <button type="button" class="btn-level-up">
                Start Learning Now
             </button>
            </a>
        </div>
    </section>

    <footer class="site-footer">
        <div class="footer-grid">
            <div class="ft-col">
                <h3>ABOUT DEVLEARN</h3>
                <ul>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="ft-col">
                <h3>COMMUNITY</h3>
                <ul>
                    <li><a href="#">Events</a></li>
                    <li><a href="#">Wall of Fame</a></li>
                    <li><a href="#">Announcements</a></li>
                    <li><a href="#">Forum</a></li>
                    <li><a href="#">Admissions</a></li>
                    <li><a href="#">Hi</a></li>
                </ul>
            </div>
            <div class="ft-col">
                <h3>DEVLEARN EDUCATION TECHNOLOGY SOLUTIONS CO., LTD</h3>
                <p>Business Registration Code: 5901235207</p>
                <p>Established Date: August 26, 2025</p>
                <p>Education and Technology – developing products to support learning</p>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="ft-logo-area">
                <span class="hdr-logo-text">DevLearn <span style="font-size:12px; color:var(--text-muted); font-weight: normal;">Unlock Potential - Lead in Technology</span></span>
            </div>
            <div class="ft-socials">
                <a href="#"><i class="fa-brands fa-facebook-f"></i> f</a>
                <a href="#"><i class="fa-brands fa-tiktok"></i> t</a>
                <a href="#"><i class="fa-brands fa-youtube"></i> y</a>
            </div>
            <div class="ft-copyright">
                © 2026 DevLearn - The leading programming learning platform in Vietnam
            </div>
        </div>
    </footer>

  <div class="user-float">
        <c:choose>
            <%-- ==========================================
                 TRẠNG THÁI 1: ĐÃ ĐĂNG NHẬP 
            ========================================== --%>
            <c:when test="${not empty sessionScope.USER}">
                <div class="user-drop" id="uDrop">
                    <div class="dd-hdr">
                        <p class="dd-signed">Signed in as</p>
                        <p class="dd-email">${sessionScope.USER.email}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/student" class="dd-row">
                        <span class="material-symbols-outlined">person</span> Profile
                    </a>
                    <a href="#" class="dd-row">
                        <span class="material-symbols-outlined">menu_book</span> My Courses
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="dd-row danger">
                        <span class="material-symbols-outlined">logout</span> Logout
                    </a>
                </div>

                <button class="user-pill" id="uBtn">
                    <div class="user-av-wrap">
                        <div class="user-av">
                            <span class="material-symbols-outlined" style="font-size: 20px;">person</span>
                        </div>
                    </div>
                    <div class="user-text">
                        <span class="user-name">Username: ${sessionScope.USER.username}</span>
                        <span class="user-email">${sessionScope.USER.email}</span>
                    </div>
                </button>
            </c:when>

            <%-- ==========================================
                 TRẠNG THÁI 2: CHƯA ĐĂNG NHẬP 
            ========================================== --%>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="user-pill" style="text-decoration: none; padding: 8px 16px 8px 8px;">
                    <div class="user-av-wrap">
                        <div class="user-av" style="background: transparent; border: 1.5px solid var(--mint);">
                            <span class="material-symbols-outlined" style="color: var(--mint); font-size: 18px;">login</span>
                        </div>
                    </div>
                    <div class="user-text">
                        <span class="user-email" style="color: var(--white); font-weight: 700; font-size: 13px;">Sign Up / Sign In</span>
                    </div>
                </a>
            </c:otherwise>
        </c:choose>
    </div>

  

    <script>
        function tog(btn) {
            const det = btn.nextElementSibling; const open = btn.classList.contains('open');
            det.style.display = open ? 'none' : 'block'; btn.classList.toggle('open', !open);
            btn.innerHTML = open ? 'View More <span class="arr">▼</span>' : 'Collapse <span class="arr">▼</span>';
        }

        const tlObs = new IntersectionObserver(entries => {
            entries.forEach(e => {
                if (e.isIntersecting) {
                    setTimeout(() => e.target.classList.add('visible'), (parseInt(e.target.dataset.index) || 0) * 80);
                    tlObs.unobserve(e.target);
                }
            });
        }, { threshold: 0.1 });
        document.querySelectorAll('.tli').forEach(el => tlObs.observe(el));

        const pbObs = new IntersectionObserver(entries => {
            entries.forEach(e => {
                if (e.isIntersecting) {
                    const f = e.target.querySelector('.ccard-prog-fill');
                    if (f) setTimeout(() => { f.style.width = f.dataset.w || '0%'; }, 250);
                    pbObs.unobserve(e.target);
                }
            });
        }, { threshold: 0.3 });
        document.querySelectorAll('.ccard').forEach(el => pbObs.observe(el));

        function countUp(el, target) {
            const dur = 1200; let t0 = null;
            (function step(ts) {
                if (!t0) t0 = ts; const p = Math.min((ts - t0) / dur, 1);
                el.textContent = Math.round((1 - Math.pow(1 - p, 3)) * target);
                if (p < 1) requestAnimationFrame(step);
            })(performance.now());
        }

        function animateRing() {
            const ring = document.getElementById('progressRing'); const label = document.getElementById('ringLabel');
            if (!ring || !label) return; const target = ${not empty completionPercent ? completionPercent : 0}; const circ = 2 * Math.PI * 25; const dur = 1300; let t0 = null;
            (function step(ts) {
                if (!t0) t0 = ts; const p = Math.min((ts - t0) / dur, 1); const eased = 1 - Math.pow(1 - p, 3);
                ring.style.strokeDashoffset = circ - eased * (circ * target / 100);
                label.textContent = Math.round(eased * target) + '%';
                if (p < 1) requestAnimationFrame(step);
            })(performance.now());
        }

        const heroObs = new IntersectionObserver(entries => {
            entries.forEach(e => {
                if (e.isIntersecting) {
                    e.target.querySelectorAll('[data-target]').forEach(el => { countUp(el, parseInt(el.dataset.target)); });
                    animateRing(); heroObs.unobserve(e.target);
                }
            });
        }, { threshold: 0.4 });
        const statsRow = document.querySelector('.stats-row');
        if (statsRow) heroObs.observe(statsRow);

        (function () {
            const btn = document.getElementById('uBtn'); const drop = document.getElementById('uDrop');
            if (!btn || !drop) return;
            btn.addEventListener('click', e => { e.stopPropagation(); drop.classList.toggle('open'); btn.classList.toggle('open'); });
            document.addEventListener('click', () => { drop.classList.remove('open'); btn.classList.remove('open'); });
        })();
        
      

 // 2. Hàm hiển thị thêm khóa học đang bị ẩn
            window.showAllTimelineItems = function() {
                const hiddenItems = document.querySelectorAll('.hidden-timeline-item');
                hiddenItems.forEach((item, index) => {
                    item.classList.remove('hidden-timeline-item');
                    setTimeout(() => { item.classList.add('visible'); }, index * 150); 
                });
                const btnContainer = document.getElementById('viewMoreContainer');
                if (btnContainer) btnContainer.style.display = 'none';
            }
    </script>
</body>
</html>
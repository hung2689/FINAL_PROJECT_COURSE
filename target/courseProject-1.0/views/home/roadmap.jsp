<%-- Document : roadmap Author : DevLearn Team --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Learning Roadmap | DevLearn</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Space+Grotesk:wght@500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>

                <style>
                    /* ── RESET ──────────────────────────────────────────────────────── */
                    *,
                    *::before,
                    *::after {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0;
                    }

                    html {
                        scroll-behavior: smooth;
                    }

                    /* ── TOKENS ──────────────────────────────────────────────────────  */
                    :root {
                        --primary: #10B981;
                        --primary-dark: #059669;
                        --primary-light: #ecfdf5;
                        --primary-brd: #a7f3d0;
                        --primary-dim: rgba(16, 185, 129, 0.1);
                        --primary-glow: rgba(16, 185, 129, 0.25);
                        --text: #0f172a;
                        --text-muted: #64748b;
                        --text-sub: #94a3b8;
                        --border: #e2e8f0;
                        --border-em: #bbf7d0;
                        --card-bg: #ffffff;
                        --section-bg: #f8fafc;
                        --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
                        --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
                        --shadow-lg: 0 12px 40px rgba(0, 0, 0, 0.1);
                        --shadow-green: 0 8px 28px rgba(16, 185, 129, 0.22);
                        --transition: 0.25s ease;
                    }

                    body {
                        font-family: 'Inter', sans-serif;
                        background: linear-gradient(135deg, #f0fdf9 0%, #e8f5f0 50%, #f8fffc 100%);
                        color: var(--text);
                        min-height: 100vh;
                        overflow-x: hidden;
                        padding-top: 72px;
                    }

                    /* ── LAYOUT ─────────────────────────────────────────────────────── */
                    .page-wrap {
                        max-width: 1360px;
                        margin: 0 auto;
                        padding: 0 24px;
                    }

                    /* ── ACTION BAR ─────────────────────────────────────────────────── */
                    .top-action-bar {
                        padding: 22px 0 0;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        flex-wrap: wrap;
                        gap: 12px;
                    }

                    .btn-back {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 9px 18px;
                        border-radius: 10px;
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        color: var(--text-muted);
                        font-size: 13.5px;
                        font-weight: 600;
                        text-decoration: none;
                        transition: all var(--transition);
                        box-shadow: var(--shadow-sm);
                    }

                    .btn-back:hover {
                        background: var(--primary-light);
                        border-color: var(--primary-brd);
                        color: var(--primary-dark);
                    }

                    .btn-back .material-symbols-outlined {
                        font-size: 18px;
                    }

                    .page-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 7px;
                        padding: 6px 16px;
                        border-radius: 999px;
                        background: var(--primary-light);
                        border: 1px solid var(--primary-brd);
                        color: #065f46;
                        font-size: 11.5px;
                        font-weight: 700;
                        letter-spacing: 0.8px;
                        text-transform: uppercase;
                    }

                    .badge-dot {
                        width: 7px;
                        height: 7px;
                        border-radius: 50%;
                        background: var(--primary);
                        animation: blink 1.6s infinite;
                    }

                    @keyframes blink {

                        0%,
                        100% {
                            opacity: 1;
                            transform: scale(1)
                        }

                        50% {
                            opacity: .4;
                            transform: scale(1.5)
                        }
                    }

                    /* ── HERO ───────────────────────────────────────────────────────── */
                    .hero {
                        text-align: center;
                        padding: 36px 20px 44px;
                    }

                    .hero h1 {
                        font-family: 'Space Grotesk', 'Inter', sans-serif;
                        font-size: clamp(24px, 4.5vw, 48px);
                        font-weight: 900;
                        color: var(--text);
                        line-height: 1.12;
                        letter-spacing: -1px;
                        text-transform: uppercase;
                        margin-bottom: 40px;
                    }

                    .hero h1 .accent {
                        background: linear-gradient(135deg, #10B981, #059669);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        display: block;
                        margin-top: 4px;
                    }

                    /* ── STATS ──────────────────────────────────────────────────────── */
                    .stats-row {
                        display: flex;
                        justify-content: center;
                        gap: 14px;
                        flex-wrap: wrap;
                        margin-bottom: 0;
                    }

                    .stat-card {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        border-radius: 18px;
                        padding: 20px 28px;
                        min-width: 148px;
                        text-align: center;
                        box-shadow: var(--shadow-sm);
                        transition: all var(--transition);
                        position: relative;
                        overflow: hidden;
                    }

                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 20%;
                        right: 20%;
                        height: 3px;
                        background: linear-gradient(90deg, transparent, var(--primary), transparent);
                    }

                    .stat-card:hover {
                        border-color: var(--primary-brd);
                        transform: translateY(-4px);
                        box-shadow: var(--shadow-green);
                    }

                    .stat-icon {
                        font-size: 22px;
                        margin-bottom: 8px;
                    }

                    .stat-val {
                        font-family: 'Space Grotesk', sans-serif;
                        font-size: 26px;
                        font-weight: 800;
                        color: var(--text);
                    }

                    .stat-val .hi {
                        color: var(--primary);
                    }

                    .stat-lbl {
                        font-size: 11px;
                        color: var(--text-muted);
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.8px;
                        margin-top: 4px;
                    }

                    .ring-wrap {
                        position: relative;
                        width: 58px;
                        height: 58px;
                        margin: 0 auto 6px;
                    }

                    .ring-wrap svg {
                        transform: rotate(-90deg);
                    }

                    .ring-bg {
                        stroke: #e2e8f0;
                    }

                    .ring-fill {
                        stroke: var(--primary);
                        stroke-linecap: round;
                        stroke-dasharray: 157;
                        stroke-dashoffset: 157;
                        transition: stroke-dashoffset 1.4s ease;
                    }

                    .ring-label {
                        position: absolute;
                        inset: 0;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 12px;
                        font-weight: 800;
                        color: var(--primary);
                    }

                    /* ── MAIN GRID ──────────────────────────────────────────────────── */
                    .main-grid {
                        display: grid;
                        grid-template-columns: 268px 1fr 290px;
                        gap: 28px;
                        align-items: start;
                        padding: 44px 0 80px;
                    }

                    /* ── SIDEBAR BLOCKS ─────────────────────────────────────────────── */
                    .left-col {
                        display: flex;
                        flex-direction: column;
                        gap: 18px;
                        position: sticky;
                        top: 88px;
                    }

                    .white-block {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        border-radius: 18px;
                        padding: 22px;
                        box-shadow: var(--shadow-sm);
                        position: relative;
                        overflow: hidden;
                    }

                    .white-block::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, var(--primary), #34d399, var(--primary));
                    }

                    .block-title {
                        font-size: 10.5px;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 1.8px;
                        color: var(--primary-dark);
                        margin-bottom: 14px;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .block-title::before {
                        content: '';
                        display: inline-block;
                        width: 3px;
                        height: 14px;
                        background: var(--primary);
                        border-radius: 999px;
                    }

                    .skill-tags {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 7px;
                    }

                    .stag {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        padding: 5px 12px;
                        border-radius: 999px;
                        border: 1px solid var(--primary-brd);
                        background: var(--primary-light);
                        color: #065f46;
                        font-size: 12px;
                        font-weight: 600;
                        transition: all var(--transition);
                    }

                    .stag:hover {
                        background: #d1fae5;
                        transform: translateY(-1px);
                    }

                    .info-row {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        margin-bottom: 13px;
                    }

                    .info-row:last-child {
                        margin-bottom: 0;
                    }

                    .info-icon {
                        width: 36px;
                        height: 36px;
                        border-radius: 10px;
                        background: var(--primary-light);
                        border: 1px solid var(--primary-brd);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 17px;
                        flex-shrink: 0;
                    }

                    .info-text strong {
                        display: block;
                        font-size: 14px;
                        font-weight: 700;
                        color: var(--text);
                        line-height: 1.25;
                    }

                    .info-text span {
                        font-size: 11.5px;
                        color: var(--text-muted);
                    }

                    /* ── TIMELINE ───────────────────────────────────────────────────── */
                    .section-eyebrow {
                        font-size: 11px;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 1.8px;
                        color: var(--primary-dark);
                        text-align: center;
                        margin-bottom: 32px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 12px;
                    }

                    .section-eyebrow::before,
                    .section-eyebrow::after {
                        content: '';
                        flex: 1;
                        max-width: 70px;
                        height: 1.5px;
                        background: var(--primary-brd);
                    }

                    .timeline {
                        position: relative;
                        padding-bottom: 20px;
                    }

                    .timeline::before {
                        content: '';
                        position: absolute;
                        left: 50%;
                        transform: translateX(-50%);
                        top: 0;
                        bottom: 0;
                        width: 2px;
                        background: linear-gradient(180deg, var(--primary) 0%, rgba(16, 185, 129, 0.15) 100%);
                        z-index: 0;
                    }

                    .tli {
                        display: flex;
                        justify-content: flex-end;
                        padding-right: calc(50% + 34px);
                        margin-bottom: 36px;
                        position: relative;
                        opacity: 0;
                        transform: translateX(-28px);
                        transition: opacity 0.5s ease, transform 0.5s ease;
                    }

                    .tli.r {
                        justify-content: flex-start;
                        padding-right: 0;
                        padding-left: calc(50% + 34px);
                        transform: translateX(28px);
                    }

                    .tli.visible {
                        opacity: 1;
                        transform: translateX(0);
                    }

                    .tli::after {
                        content: '';
                        position: absolute;
                        left: 50%;
                        top: 26px;
                        transform: translateX(-50%);
                        width: 14px;
                        height: 14px;
                        border-radius: 50%;
                        background: var(--primary-light);
                        border: 2.5px solid var(--primary);
                        z-index: 2;
                        transition: all var(--transition);
                        box-shadow: 0 0 10px var(--primary-glow);
                    }

                    .tli:hover::after {
                        background: var(--primary);
                        transform: translateX(-50%) scale(1.35);
                    }

                    .tli-num {
                        position: absolute;
                        left: 50%;
                        top: -10px;
                        transform: translateX(-50%);
                        background: var(--primary);
                        color: #fff;
                        font-size: 9px;
                        font-weight: 900;
                        width: 20px;
                        height: 20px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        z-index: 3;
                    }

                    /* ── COURSE CARD ────────────────────────────────────────────────── */
                    .ccard {
                        background: var(--card-bg);
                        border-radius: 18px;
                        padding: 22px;
                        width: 100%;
                        max-width: 390px;
                        box-shadow: var(--shadow-md);
                        transition: all var(--transition);
                        border: 1.5px solid var(--border);
                    }

                    .ccard:hover {
                        transform: translateY(-5px);
                        border-color: var(--primary-brd);
                        box-shadow: 0 16px 40px rgba(16, 185, 129, 0.15);
                    }

                    .ccard-top {
                        display: flex;
                        align-items: flex-start;
                        gap: 13px;
                        margin-bottom: 12px;
                    }

                    .ccard-ico {
                        width: 44px;
                        height: 44px;
                        border-radius: 11px;
                        background: var(--primary-light);
                        border: 1.5px solid var(--primary-brd);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 20px;
                        flex-shrink: 0;
                    }

                    .ccard-title {
                        font-size: 13.5px;
                        font-weight: 800;
                        color: var(--text);
                        text-transform: uppercase;
                        margin-bottom: 3px;
                    }

                    .ccard-sub {
                        font-size: 11px;
                        color: var(--text-muted);
                        font-weight: 600;
                    }

                    .ccard-desc {
                        font-size: 12.5px;
                        color: var(--text-muted);
                        line-height: 1.65;
                        margin-bottom: 14px;
                    }

                    .ccard-prog {
                        margin-bottom: 14px;
                    }

                    .ccard-prog-top {
                        display: flex;
                        justify-content: space-between;
                        font-size: 10.5px;
                        color: var(--text-sub);
                        margin-bottom: 6px;
                        font-weight: 600;
                    }

                    .ccard-prog-bar {
                        height: 5px;
                        background: #e2e8f0;
                        border-radius: 999px;
                        overflow: hidden;
                    }

                    .ccard-prog-fill {
                        height: 100%;
                        border-radius: 999px;
                        background: linear-gradient(90deg, #10b981, #34d399);
                        transition: width 1.2s ease;
                    }

                    .ccard-details {
                        display: none;
                        font-size: 12px;
                        color: var(--text-muted);
                        line-height: 1.7;
                        margin-bottom: 12px;
                        padding: 10px 14px;
                        background: var(--primary-light);
                        border-radius: 10px;
                        border-left: 3px solid var(--primary);
                    }

                    .ccard-details ul {
                        list-style: none;
                    }

                    .ccard-details li {
                        display: flex;
                        align-items: flex-start;
                        gap: 7px;
                        padding: 2px 0;
                    }

                    .ccard-details li::before {
                        content: '✓';
                        color: var(--primary);
                        font-weight: 700;
                        font-size: 11px;
                        margin-top: 1px;
                    }

                    .ccard-toggle {
                        display: inline-flex;
                        align-items: center;
                        gap: 4px;
                        font-size: 12px;
                        font-weight: 600;
                        color: var(--primary-dark);
                        background: none;
                        border: none;
                        cursor: pointer;
                        padding: 0;
                        margin-bottom: 12px;
                    }

                    .ccard-toggle .arr {
                        transition: transform 0.3s;
                        font-size: 10px;
                    }

                    .ccard-toggle.open .arr {
                        transform: rotate(180deg);
                    }

                    .ccard-foot {
                        border-top: 1px solid var(--border);
                        padding-top: 13px;
                    }

                    .btn-start {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 7px;
                        width: 100%;
                        padding: 11px 18px;
                        border-radius: 10px;
                        background: linear-gradient(135deg, #10b981, #059669);
                        color: #fff;
                        font-size: 13px;
                        font-weight: 700;
                        border: none;
                        cursor: pointer;
                        text-decoration: none;
                        transition: all var(--transition);
                        box-shadow: var(--shadow-green);
                    }

                    .btn-start:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 10px 28px rgba(16, 185, 129, 0.4);
                    }

                    .btn-coming {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 7px;
                        width: 100%;
                        padding: 11px 18px;
                        border-radius: 10px;
                        font-size: 13px;
                        font-weight: 600;
                        background: #f1f5f9;
                        color: #94a3b8;
                        border: 1.5px solid var(--border);
                        cursor: not-allowed;
                    }

                    .tl-more {
                        text-align: center;
                        padding-top: 12px;
                    }

                    .btn-view-more {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 12px 30px;
                        border-radius: 12px;
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        color: var(--text-muted);
                        font-size: 13.5px;
                        font-weight: 700;
                        cursor: pointer;
                        transition: all var(--transition);
                        box-shadow: var(--shadow-sm);
                    }

                    .btn-view-more:hover {
                        background: var(--primary-light);
                        border-color: var(--primary-brd);
                        color: var(--primary-dark);
                    }

                    .hidden-timeline-item {
                        display: none !important;
                    }

                    /* ── RIGHT CTA ──────────────────────────────────────────────────── */
                    .right-col {
                        position: sticky;
                        top: 88px;
                    }

                    .cta-block {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        border-radius: 22px;
                        padding: 32px 24px;
                        text-align: center;
                        box-shadow: var(--shadow-md);
                        position: relative;
                        overflow: hidden;
                    }

                    .cta-block::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, var(--primary), #34d399, var(--primary));
                    }

                    .cta-block::after {
                        content: '';
                        position: absolute;
                        top: -80px;
                        right: -80px;
                        width: 200px;
                        height: 200px;
                        border-radius: 50%;
                        background: radial-gradient(circle, rgba(16, 185, 129, 0.08) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .cta-emoji {
                        font-size: 44px;
                        display: block;
                        margin-bottom: 14px;
                    }

                    .cta-title {
                        font-family: 'Space Grotesk', sans-serif;
                        font-size: 22px;
                        font-weight: 800;
                        color: var(--text);
                        text-transform: uppercase;
                        line-height: 1.2;
                        margin-bottom: 11px;
                    }

                    .cta-desc {
                        font-size: 13.5px;
                        color: var(--text-muted);
                        line-height: 1.7;
                        margin-bottom: 22px;
                    }

                    .btn-cta {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;
                        width: 100%;
                        padding: 14px 20px;
                        background: linear-gradient(135deg, #10B981, #059669);
                        color: #fff;
                        border-radius: 13px;
                        font-size: 14px;
                        font-weight: 800;
                        border: none;
                        cursor: pointer;
                        text-decoration: none;
                        transition: all var(--transition);
                        text-transform: uppercase;
                        letter-spacing: 0.4px;
                        box-shadow: var(--shadow-green);
                    }

                    .btn-cta:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 14px 36px rgba(16, 185, 129, 0.38);
                    }

                    .cta-divider {
                        border: none;
                        border-top: 1px solid var(--border);
                        margin: 20px 0;
                    }

                    .cta-mini {
                        display: flex;
                        justify-content: space-between;
                        font-size: 12.5px;
                        color: var(--text-muted);
                        margin-bottom: 8px;
                    }

                    .cta-mini strong {
                        color: var(--primary-dark);
                        font-weight: 700;
                    }

                    /* ── BANNER ─────────────────────────────────────────────────────── */
                    .breakthrough-banner {
                        max-width: 1360px;
                        margin: 0 auto 60px;
                        padding: 0 24px;
                    }

                    .banner-inner {
                        background: linear-gradient(135deg, #ecfdf5, #d1fae5);
                        border: 1px solid var(--primary-brd);
                        border-radius: 24px;
                        padding: 60px 24px;
                        text-align: center;
                        position: relative;
                        overflow: hidden;
                        box-shadow: var(--shadow-lg);
                    }

                    .banner-inner::before {
                        content: '';
                        position: absolute;
                        top: -60px;
                        right: -60px;
                        width: 250px;
                        height: 250px;
                        border-radius: 50%;
                        background: radial-gradient(circle, rgba(16, 185, 129, 0.15) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .banner-inner::after {
                        content: '';
                        position: absolute;
                        bottom: -60px;
                        left: -60px;
                        width: 200px;
                        height: 200px;
                        border-radius: 50%;
                        background: radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .banner-inner h2 {
                        font-family: 'Space Grotesk', sans-serif;
                        font-size: clamp(22px, 3vw, 32px);
                        font-weight: 900;
                        color: var(--text);
                        margin-bottom: 14px;
                        position: relative;
                        z-index: 1;
                    }

                    .banner-inner p {
                        font-size: 15px;
                        color: var(--text-muted);
                        margin-bottom: 30px;
                        max-width: 560px;
                        margin-inline: auto;
                        position: relative;
                        z-index: 1;
                        line-height: 1.7;
                    }

                    .btn-banner {
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        padding: 14px 40px;
                        background: linear-gradient(135deg, #10B981, #059669);
                        color: #fff;
                        border-radius: 999px;
                        font-weight: 800;
                        font-size: 14px;
                        text-transform: uppercase;
                        text-decoration: none;
                        position: relative;
                        z-index: 1;
                        transition: all var(--transition);
                        box-shadow: var(--shadow-green);
                        border: none;
                        cursor: pointer;
                        letter-spacing: 0.5px;
                    }

                    .btn-banner:hover {
                        transform: translateY(-4px);
                        box-shadow: 0 16px 40px rgba(16, 185, 129, 0.4);
                    }

                    /* ── FOOTER ─────────────────────────────────────────────────────── */
                    .site-footer {
                        background: #fff;
                        border-top: 1px solid var(--border);
                        padding: 64px 24px 36px;
                    }

                    .footer-inner {
                        max-width: 1360px;
                        margin: 0 auto;
                    }

                    .footer-grid {
                        display: grid;
                        grid-template-columns: 2fr 1fr 1fr 1fr;
                        gap: 48px;
                        margin-bottom: 48px;
                    }

                    .footer-logo-link {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        margin-bottom: 14px;
                        text-decoration: none;
                    }

                    .footer-logo-box {
                        width: 40px;
                        height: 40px;
                        border-radius: 10px;
                        background: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #fff;
                        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
                    }

                    .footer-logo-name {
                        font-size: 20px;
                        font-weight: 800;
                        color: var(--text);
                    }

                    .footer-desc {
                        font-size: 13.5px;
                        color: var(--text-muted);
                        line-height: 1.7;
                        max-width: 280px;
                        margin-bottom: 20px;
                    }

                    .footer-socials {
                        display: flex;
                        gap: 10px;
                    }

                    .footer-social-btn {
                        width: 36px;
                        height: 36px;
                        border-radius: 50%;
                        border: 1px solid var(--border);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: var(--text-muted);
                        text-decoration: none;
                        transition: all var(--transition);
                    }

                    .footer-social-btn:hover {
                        background: var(--primary);
                        border-color: var(--primary);
                        color: #fff;
                        transform: translateY(-3px);
                    }

                    .footer-col-title {
                        font-size: 11px;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 1.5px;
                        color: var(--text);
                        margin-bottom: 18px;
                    }

                    .footer-links {
                        list-style: none;
                        display: flex;
                        flex-direction: column;
                        gap: 11px;
                    }

                    .footer-links a {
                        font-size: 13.5px;
                        color: var(--text-muted);
                        text-decoration: none;
                        transition: color 0.2s;
                    }

                    .footer-links a:hover {
                        color: var(--primary);
                    }

                    .footer-bottom {
                        padding-top: 24px;
                        border-top: 1px solid var(--border);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 12px;
                        color: var(--text-sub);
                        font-size: 13px;
                    }

                    .footer-bottom-right {
                        display: flex;
                        gap: 20px;
                        align-items: center;
                        color: var(--text-muted);
                    }

                    /* ── RESPONSIVE ─────────────────────────────────────────────────── */
                    @media(max-width: 1100px) {
                        .main-grid {
                            grid-template-columns: 230px 1fr 256px;
                            gap: 20px;
                        }
                    }

                    @media(max-width: 860px) {
                        .main-grid {
                            grid-template-columns: 1fr;
                        }

                        .left-col,
                        .right-col {
                            position: static;
                        }

                        .tli,
                        .tli.r {
                            padding: 0 0 0 52px;
                            justify-content: flex-start;
                        }

                        .tli::after {
                            left: 18px;
                        }

                        .tli-num {
                            left: 18px;
                        }

                        .timeline::before {
                            left: 18px;
                        }

                        .ccard {
                            max-width: 100%;
                        }

                        .footer-grid {
                            grid-template-columns: repeat(2, 1fr);
                            gap: 32px;
                        }
                    }

                    @media(max-width: 580px) {
                        .stats-row {
                            gap: 10px;
                        }

                        .stat-card {
                            min-width: 130px;
                        }

                        .footer-grid {
                            grid-template-columns: 1fr;
                        }

                        .footer-bottom {
                            flex-direction: column;
                            text-align: center;
                        }
                    }
                </style>
            </head>

            <body>

                <!-- ── SHARED HEADER ──────────────────────────────────────────────────────── -->
                <jsp:include page="../common/header.jsp" />

                <!-- ── SHARED USER PILL ───────────────────────────────────────────────────── -->
                <jsp:include page="../common/userbuttom.jsp" />

                <!-- Header override: keep dark glass nav on light bg -->
                <style>
                    header.glass-header-nav,
                    .glass-header-nav {
                        background: rgba(15, 23, 42, 0.95) !important;
                        backdrop-filter: blur(20px) !important;
                        -webkit-backdrop-filter: blur(20px) !important;
                        border-bottom: 1px solid rgba(16, 185, 129, 0.2) !important;
                        box-shadow: 0 4px 32px rgba(0, 0, 0, 0.25) !important;
                        position: fixed !important;
                        top: 0 !important;
                        left: 0 !important;
                        width: 100% !important;
                        z-index: 50 !important;
                    }
                </style>

                <!-- ── PAGE ───────────────────────────────────────────────────────────────── -->
                <div class="page-wrap">
                    <div class="top-action-bar">
                        <a href="${pageContext.request.contextPath}/learningpaths" class="btn-back">
                            <span class="material-symbols-outlined">arrow_back</span> Edit Profile
                        </a>
                        <div class="page-badge">
                            <span class="badge-dot"></span> Personal Learning Roadmap
                        </div>
                    </div>

                    <!-- HERO -->
                    <section class="hero" id="heroSection">
                        <h1>
                            Roadmap to Master
                            <span class="accent">${roadmapName}</span>
                        </h1>
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
                                    <svg width="58" height="58" viewBox="0 0 58 58">
                                        <circle class="ring-bg" cx="29" cy="29" r="25" fill="none" stroke-width="5" />
                                        <circle class="ring-fill" cx="29" cy="29" r="25" fill="none" stroke-width="5"
                                            id="progressRing" />
                                    </svg>
                                    <div class="ring-label" id="ringLabel">0%</div>
                                </div>
                                <div class="stat-lbl">Completed</div>
                            </div>
                        </div>
                    </section>

                    <!-- MAIN GRID -->
                    <div class="main-grid">

                        <!-- LEFT -->
                        <aside class="left-col">
                            <div class="white-block">
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
                            <div class="white-block">
                                <div class="block-title">Your Progress</div>
                                <div class="info-row">
                                    <div class="info-icon">🏆</div>
                                    <div class="info-text">
                                        <strong>0 / ${totalCourses} Completed</strong>
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

                        <!-- MIDDLE TIMELINE -->
                        <main class="mid-col">
                            <div class="section-eyebrow">Learning Journey</div>
                            <div class="timeline">
                                <c:forEach items="${courseList}" var="course" varStatus="loop">
                                    <div class="tli ${loop.index % 2 != 0 ? 'r' : ''} ${loop.index >= 4 ? 'hidden-timeline-item' : ''}"
                                        data-index="${loop.index}">
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
                                            <button class="ccard-toggle" onclick="tog(this)">View Details <span
                                                    class="arr">▼</span></button>
                                            <div class="ccard-details">
                                                <ul>
                                                    <li>Price: $${course.price}</li>
                                                </ul>
                                            </div>
                                            <div class="ccard-foot">
                                                <c:choose>
                                                    <c:when test="${course.status == 'ACTIVE'}">
                                                        <a href="${pageContext.request.contextPath}/shop"
                                                            class="btn-start" style="text-decoration:none;">
                                                            <span class="material-symbols-outlined"
                                                                style="font-size:17px">play_circle</span>
                                                            Start Learning Now
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn-coming" disabled>🔮 Coming Soon</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${totalCourses > 4}">
                                    <div class="tl-more" id="viewMoreContainer">
                                        <button type="button" class="btn-view-more" onclick="showAllTimelineItems()">
                                            <span class="material-symbols-outlined"
                                                style="font-size:18px">expand_more</span>
                                            View More Courses
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </main>

                        <!-- RIGHT CTA -->
                        <aside class="right-col">
                            <div class="cta-block">
                                <span class="cta-emoji">🚀</span>
                                <div class="cta-title">Ready to<br>Level Up?</div>
                                <p class="cta-desc">Begin your journey to master technology today. One step each day —
                                    that's how professionals are made.</p>
                                <a href="${pageContext.request.contextPath}/shop" class="btn-cta"
                                    style="text-decoration:none;">
                                    <span class="material-symbols-outlined" style="font-size:18px">bolt</span>
                                    Start Learning Now
                                </a>
                                <hr class="cta-divider">
                                <div class="cta-mini"><span>Subjects</span><strong>${totalCourses}</strong></div>
                                <div class="cta-mini"><span>Completed</span><strong>${not empty completionPercent ?
                                        completionPercent : 0}%</strong></div>
                                <div class="cta-mini"><span>Available Now</span><strong>${totalCourses} Courses</strong>
                                </div>
                            </div>
                        </aside>
                    </div>
                </div>

                <!-- ── BANNER ─────────────────────────────────────────────────────────────── -->
                <section class="breakthrough-banner">
                    <div class="banner-inner">
                        <h2>Ready for a Breakthrough?</h2>
                        <p>A journey of a thousand miles begins with a single step. Start with your first skill today
                            and unlock your potential.</p>
                        <a href="${pageContext.request.contextPath}/shop" class="btn-banner"
                            style="text-decoration:none;">
                            <span class="material-symbols-outlined" style="font-size:20px">rocket_launch</span>
                            Start Learning Now
                        </a>
                    </div>
                </section>

                <!-- ── FOOTER ─────────────────────────────────────────────────────────────── -->
                <footer class="site-footer">
                    <div class="footer-inner">
                        <div class="footer-grid">
                            <div>
                                <a href="${pageContext.request.contextPath}/home" class="footer-logo-link">
                                    <div class="footer-logo-box"><span class="material-symbols-outlined"
                                            style="font-size:20px;font-weight:700">terminal</span></div>
                                    <span class="footer-logo-name">DevLearn</span>
                                </a>
                                <p class="footer-desc">Accompanying thousands of students on their journey to becoming
                                    professional software engineers.</p>
                                <div class="footer-socials">
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">social_leaderboard</span></a>
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">terminal</span></a>
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">smart_display</span></a>
                                </div>
                            </div>
                            <div>
                                <div class="footer-col-title">Courses</div>
                                <ul class="footer-links">
                                    <li><a href="#">Frontend Development</a></li>
                                    <li><a href="#">Backend Development</a></li>
                                    <li><a href="#">Mobile Development</a></li>
                                    <li><a href="#">Data Science &amp; AI</a></li>
                                    <li><a href="#">DevOps &amp; Cloud</a></li>
                                </ul>
                            </div>
                            <div>
                                <div class="footer-col-title">Resources</div>
                                <ul class="footer-links">
                                    <li><a href="#">Tech Blog</a></li>
                                    <li><a href="#">Community</a></li>
                                    <li><a href="#">Free Materials</a></li>
                                    <li><a href="#">YouTube Channel</a></li>
                                    <li><a href="#">IT Podcast</a></li>
                                </ul>
                            </div>
                            <div>
                                <div class="footer-col-title">Company</div>
                                <ul class="footer-links">
                                    <li><a href="#">About Us</a></li>
                                    <li><a href="${pageContext.request.contextPath}/teacher-jobs">Careers</a></li>
                                    <li><a href="#">Terms of Service</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                    <li><a href="#">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="footer-bottom">
                            <span>© 2024 DevLearn Academy. Built for the tech community.</span>
                            <div class="footer-bottom-right">
                                <span style="display:flex;align-items:center;gap:5px"><span
                                        class="material-symbols-outlined" style="font-size:16px">language</span>
                                    English</span>
                                <span style="display:flex;align-items:center;gap:5px"><span
                                        class="material-symbols-outlined" style="font-size:16px">support_agent</span>
                                    1900 1234</span>
                            </div>
                        </div>
                    </div>
                </footer>

                <script>
                    function tog(btn) {
                        const det = btn.nextElementSibling, open = btn.classList.contains('open');
                        det.style.display = open ? 'none' : 'block';
                        btn.classList.toggle('open', !open);
                        btn.innerHTML = open ? 'View Details <span class="arr">▼</span>' : 'Collapse <span class="arr">▼</span>';
                    }

                    // Timeline animation
                    const tlObs = new IntersectionObserver(entries => {
                        entries.forEach(e => {
                            if (e.isIntersecting) {
                                setTimeout(() => e.target.classList.add('visible'), (parseInt(e.target.dataset.index) || 0) * 90);
                                tlObs.unobserve(e.target);
                            }
                        });
                    }, { threshold: 0.1 });
                    document.querySelectorAll('.tli').forEach(el => tlObs.observe(el));

                    // Progress bars
                    const pbObs = new IntersectionObserver(entries => {
                        entries.forEach(e => {
                            if (e.isIntersecting) {
                                const f = e.target.querySelector('.ccard-prog-fill');
                                if (f) setTimeout(() => { f.style.width = f.dataset.w || '0%'; }, 280);
                                pbObs.unobserve(e.target);
                            }
                        });
                    }, { threshold: 0.3 });
                    document.querySelectorAll('.ccard').forEach(el => pbObs.observe(el));

                    // Count-up
                    function countUp(el, target) {
                        const dur = 1200; let t0 = null;
                        (function step(ts) {
                            if (!t0) t0 = ts;
                            const p = Math.min((ts - t0) / dur, 1);
                            el.textContent = Math.round((1 - Math.pow(1 - p, 3)) * target);
                            if (p < 1) requestAnimationFrame(step);
                        })(performance.now());
                    }

                    // Ring
                    function animateRing() {
                        const ring = document.getElementById('progressRing'), label = document.getElementById('ringLabel');
                        if (!ring || !label) return;
                        const target = ${ not empty completionPercent ?completionPercent: 0};
                        const circ = 2 * Math.PI * 25; const dur = 1300; let t0 = null;
                        (function step(ts) {
                            if (!t0) t0 = ts;
                            const p = Math.min((ts - t0) / dur, 1), eased = 1 - Math.pow(1 - p, 3);
                            ring.style.strokeDashoffset = circ - eased * (circ * target / 100);
                            label.textContent = Math.round(eased * target) + '%';
                            if (p < 1) requestAnimationFrame(step);
                        })(performance.now());
                    }

                    const heroObs = new IntersectionObserver(entries => {
                        entries.forEach(e => {
                            if (e.isIntersecting) {
                                e.target.querySelectorAll('[data-target]').forEach(el => countUp(el, parseInt(el.dataset.target)));
                                animateRing(); heroObs.unobserve(e.target);
                            }
                        });
                    }, { threshold: 0.3 });
                    const statsRow = document.querySelector('.stats-row');
                    if (statsRow) heroObs.observe(statsRow);

                    // View more
                    window.showAllTimelineItems = function () {
                        document.querySelectorAll('.hidden-timeline-item').forEach((item, i) => {
                            item.classList.remove('hidden-timeline-item');
                            setTimeout(() => item.classList.add('visible'), i * 150);
                        });
                        const c = document.getElementById('viewMoreContainer');
                        if (c) c.style.display = 'none';
                    };
                </script>
            </body>

            </html>
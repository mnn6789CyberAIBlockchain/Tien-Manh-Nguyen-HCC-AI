import re

# Patterns that indicate likely prompt injection or sensitive-data exfiltration attempts
SUSPICIOUS_PATTERNS = [
    r"ignore (all|previous) instructions",
    r"reveal .*password",
    r"reveal .*passphrase",
    r"reveal .*code",
    r"show .*secret",
    r"show .*internal",
    r"show .*restricted",
    r"print .*admin",
    r"print .*internal",
    r"print .*restricted",
    r"bypass .*policy",
    r"leak .*data",
    r"dump .*database",
    r"system prompt",
    r"developer instructions",
    r"internal manager override code",
    r"admin passphrase",
    r"vip customer notes",
    r"vip customers",
    r"customer preferences",
    r"allergy notes",
    r"restricted admin notes",
    r"do not share",
    r"private admin",
    r"internal only",
]

# Extra sensitive keywords that are not always malicious by themselves,
# but strongly increase suspicion when used in a request
SENSITIVE_KEYWORDS = [
    "vip",
    "override code",
    "passphrase",
    "admin",
    "restricted",
    "internal",
    "private",
    "do not share",
    "allergy notes",
    "customer notes",
    "manager notes",
]

def calculate_risk_score(user_input: str) -> int:
    """
    Simple scoring model:
    - +2 for each suspicious regex match
    - +1 for each sensitive keyword found
    """
    text = user_input.lower()
    score = 0

    for pattern in SUSPICIOUS_PATTERNS:
        if re.search(pattern, text):
            score += 2

    for keyword in SENSITIVE_KEYWORDS:
        if keyword in text:
            score += 1

    return score

def classify_intent(score: int) -> str:
    """
    Converts numeric score into a simple intent label.
    """
    if score >= 4:
        return "malicious"
    elif score >= 2:
        return "suspicious"
    else:
        return "safe"

def detect_prompt_injection(user_input: str):
    """
    Returns:
    - is_malicious (bool)
    - reason (str)

    We block anything classified as malicious.
    Suspicious prompts can still be treated as blocked too if you want stricter behavior.
    """
    text = user_input.lower()

    matched_patterns = []
    matched_keywords = []

    for pattern in SUSPICIOUS_PATTERNS:
        if re.search(pattern, text):
            matched_patterns.append(pattern)

    for keyword in SENSITIVE_KEYWORDS:
        if keyword in text:
            matched_keywords.append(keyword)

    score = calculate_risk_score(user_input)
    intent = classify_intent(score)

    if intent == "malicious":
        reason_parts = []

        if matched_patterns:
            reason_parts.append(f"Matched suspicious patterns: {', '.join(matched_patterns)}")
        if matched_keywords:
            reason_parts.append(f"Sensitive keywords detected: {', '.join(matched_keywords)}")

        reason = " | ".join(reason_parts) if reason_parts else "High-risk prompt detected"
        return True, reason

    return False, f"No malicious prompt detected (intent={intent}, score={score})"
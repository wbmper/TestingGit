import sys
import re

if len(sys.argv) != 2:
    print("Usage: python format_tidy_report.py <clang-tidy-output.txt>")
    sys.exit(1)

input_file = sys.argv[1]

FRIENDLY_TEMPLATES = {
    'unused variable': "선언된 변수 `'{var}'`가 사용되지 않고 있어요. 불필요하다면 제거해보는 게 좋겠어요!",
    'const_cast': "`const_cast`는 위험할 수 있어서 가능한 다른 방법을 고려해보면 좋아요.",
    'use nullptr': "`NULL` 대신 `nullptr`을 사용하는 게 더 현대적이고 안전해요.",
    'infinite loop': "이 루프는 종료 조건이 없어 보여요. 혹시 무한 루프가 의도된 거라면 주석으로 명시해주는 건 어때요?",
}

def get_friendly_comment(warning_msg):
    for key, comment in FRIENDLY_TEMPLATES.items():
        if key in warning_msg.lower():
            return comment
    return None

with open(input_file, 'r') as f:
    lines = f.readlines()

print("### Clang-Tidy 분석 결과 요약\n")
print("아래는 코드에서 감지된 잠재적인 문제들이에요. 확인해보고 개선할 수 있는 부분이 있다면 같이 정리해봐요!\n")

warn_count = 0
for line in lines:
    match = re.match(r'(.*):(\d+):(\d+): warning: (.*) \[(.*)\]', line)
    if match:
        filepath, line_no, col_no, message, rule = match.groups()
        warn_count += 1
        comment = get_friendly_comment(message)

        print(f"#### `{filepath}:{line_no}`")
        print(f"> {message}")
        if comment:
            print(f"> **코멘트:** {comment}")
        print(f"> _(경고 유형: `{rule}`)_\n")

if warn_count == 0:
    print("✅ **아주 멋져요! clang-tidy가 감지한 문제가 없어요.**")

print("\n---\n_이 코멘트는 clang-tidy 자동 리뷰 봇이 작성했어요._")

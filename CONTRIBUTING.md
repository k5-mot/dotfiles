# Contributing

この文書の規範語はRFC 8174に従います。
`MUST`、`MUST NOT`、`SHOULD`、`SHOULD NOT`、`MAY` は大文字で書かれた場合だけRFC 2119/RFC 8174上の意味を持ちます。
小文字のmust、should、mayは通常の文章として扱います。

## 1. Branch strategy

- branch strategyはGitHub Flowに従わなければならない（MUST）。
- `main`は常にrelease可能な状態に保たなければならない（MUST）。
- 作業branchは短命でなければならない（SHOULD）。
- pull requestは1つの目的だけを扱うべきである（SHOULD）。
- merge前にCIを通過させなければならない（MUST）。
- 長期branchや環境別branchを作るべきではない（SHOULD NOT）。

## 2. Commit message

- commit messageは日本語で書かなければならない（MUST）。
- commit messageはgitmoji付きConventional Commits形式に従わなければならない（MUST）。
- subjectは50文字以内で、句点で終えてはならない（MUST NOT）。
- commitの理由がsubjectだけでは不足する場合、bodyを追加すべきである（SHOULD）。
- commit作成にはgit-czを使うべきである（SHOULD）。
- `git-cz`のtype、emoji、scope候補、message formatは`.git-cz.json`で管理すべきである（SHOULD）。

形式:

```text
<gitmoji> <type>(<scope>): <日本語のsubject>
```

`git-cz`の対話入力ではsubjectを日本語で入力します。

例:

```text
✨ feat(api): ユーザー検索を追加
🐛 fix(auth): 認証失敗時の分岐を修正
📝 docs(setup): Windows手順を更新
```

## 3. Commit granularity

- 1 commitは1つの論理変更だけを含まなければならない（MUST）。
- commitは単独でrevertでき、buildとtestが成功する状態でなければならない（MUST）。
- refactorと動作変更は別commitにしなければならない（MUST）。
- 同じ作業で発生した軽微な修正を、意味のない独立commitにしてはならない（MUST NOT）。
- unrelatedな変更を同じcommitへ含めてはならない（MUST NOT）。
- AI agentはtaskまたはsubtaskの完了ごとにcommitしなければならない（MUST）。
- AI agentは明示的な依頼なしにwork in progressをcommitしてはならない（MUST NOT）。

## 4. Tag strategy

- tag strategyはSemVerに従わなければならない（MUST）。
- tag名は`v<MAJOR>.<MINOR>.<PATCH>`形式でなければならない（MUST）。
- prerelease tagを採用してはならない（MUST NOT）。
- build metadata付きtagを採用してはならない（MUST NOT）。
- `v1.2.0-alpha.1`のようなtagを作成してはならない（MUST NOT）。
- `1.2.3`のように先頭`v`が無いtagを作成してはならない（MUST NOT）。

SemVerの判断:

- `MAJOR`: 互換性を壊す変更。
- `MINOR`: 後方互換の機能追加。
- `PATCH`: 後方互換のバグ修正、ドキュメント、運用改善。

タグ例:

```bash
git tag -a v1.2.3 -m "v1.2.3"
git push origin v1.2.3
```

## References

- [RFC 8174: Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/info/rfc8174/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html)

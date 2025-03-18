-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, t, i, c, sn = ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {

  s({ trig = "model", name = "model definition", dscr = "model definition template" },
    fmt([[
      model {} {{
        id Int @id @default(autoincrement())

        createdAt DateTime @default(now())
        updatedAt DateTime @updatedAt
      }}
      {}
    ]], { i(1, "model"), i(0) })
  ),
  s({ trig = "field", name = "model field", dscr = "prisma model field template" },
    fmt('{} {}{} {}\n{}', {
      i(1, "field"),
      c(2, {
        t("Int"),
        t("String"),
        t("Boolean"),
        t("BigInt"),
        t("Float"),
        t("DateTime"),
        t("Json"),
        t("Bytes"),
        t("Unsupported"),
      }),
      c(3, {
        t(""),
        t("[]"),
        t("?"),
        t("[]?"),
      }),
      c(4, {
        t(""),
        t("@id"),
        t("@@id"),
        t("@default"),
        t("@unique"),
        t("@@unique"),
        t("@@index"),
        t("@relation"),
        t("@map"),
        t("@@map"),
        t("@updatedAt"),
        t("@ignore"),
        t("@@ignore"),
        t("@schema"),
      }),
      i(0)
    })
  ),

  s({ trig = "attr", name = "field attribute", dscr = "field attribute template" },
    fmt('{}\n{}', {
      c(1, {
        t("@relation"),
        t("@unique"),
        t("@@unique"),
        t("@id"),
        t("@@id"),
        t("@default"),
        t("@@index"),
        t("@map"),
        t("@@map"),
        t("@updatedAt"),
        t("@ignore"),
        t("@@ignore"),
        t("@@schema"),
      }),
      i(0),
    })
  ),

  s({ trig = "pf", name = "filter methods", dscr = "prisma filter method templates" },
    fmt('await prisma.{}.{};\n{}', {
      i(1, "model"),
      c(2, {
        t("findFirst()"),
        fmt('findMany({})', { c(1, { t(""), sn(nil, fmt('{{\n\twhere: {{\n\t\t{}\n\t}}\n}}', i(1, "filter"))) }) }),
      }),
      i(0),
    })
  ),

  s({ trig = "pc", name = "craete record", dscr = "prisma create method templates" },
    fmt([[
      await prisma.{}.create({{
        data: {{
          {}
        }}
      }})
      {}
    ]], { i(1, "model"), i(2, "data"), i(0) })
  ),

  s({ trig = "pu", name = "update record", dscr = "prisma update method templates" },
    fmt([[
      await prisma.{}.update({{
        where: {{
          {}
        }},
        data: {{
          {}
        }},
      }})
      {}
    ]], { i(1, "model"), i(2, "filter"), i(3, "content"), i(0) })
  ),

  s({ trig = "pd", name = "delete record", dscr = "prisma delete method templates" },
    fmt([[
      await prisma.{}.delete({{
        where: {{
          {}
        }}
      }})
      {}
    ]], { i(1, "model"), i(2, "filter"), i(0) })
  ),

  s({ trig = "enum", name = "enum template", dscr = "prisma enum template" },
    fmt('enum {} {{\n\t{}\n}}\n{}', { i(1, "name"), i(2, "value"), i(0) })
  ),

  s({ trig = "many", name = "many relationship", dscr = "define many relationship" },
    fmt('{} {}[]\n{}', { i(1, "field"), i(2, "type"), i(0) })
  ),

  s({ trig = "belongs", name = "belong relationship", dscr = "define belong relationship" },
    fmt('{} {} @relation(fields: [{}], references: [{}], onDelete: {})\n{}', {
      i(1, "field"),
      i(2, "type"),
      i(3, "ID reference from this model"),
      i(4, "Foreign key"),
      c(5, { t("SetNull"), t("NoAction"), t("Cascade") }),
      i(0),
    })
  ),

  s({ trig = "index",  name = "index template",  dscr = "define index" },
    fmt('@@index([{}])\n{}',  { i(1, "field"), i(0) })
  ),
  s({ trig = "unique", name = "unique template", dscr = "define unique" },
    fmt('@@unique([{}])\n{}', { i(1, "field"), i(0) })
  ),
}

return snippets

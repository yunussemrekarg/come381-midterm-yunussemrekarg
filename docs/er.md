

\# Gym and Training Management System



```mermaid

erDiagram

&#x20;   MEMBER ||--o{ SESSION\_REGISTRATION : registers

&#x20;   TRAINING\_SESSION ||--o{ SESSION\_REGISTRATION : includes

&#x20;   TRAINER ||--o{ TRAINING\_SESSION : leads



&#x20;   MEMBER {

&#x20;       int member\_id PK

&#x20;       string first\_name

&#x20;       string last\_name

&#x20;       date join\_date

&#x20;   }



&#x20;   TRAINER {

&#x20;       int trainer\_id PK

&#x20;       string first\_name

&#x20;       string last\_name

&#x20;       string specialization

&#x20;   }



&#x20;   TRAINING\_SESSION {

&#x20;       int session\_id PK

&#x20;       date session\_date

&#x20;       time start\_time

&#x20;       int trainer\_id FK

&#x20;   }



&#x20;   SESSION\_REGISTRATION {

&#x20;       int registration\_id PK

&#x20;       int member\_id FK

&#x20;       int session\_id FK

&#x20;   }

```

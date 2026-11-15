select
    employeeid,
    firstname,
    lastname,
    concat(firstname, ' ', lastname) as employeename,
    jobtitle,
    updated_at
from
    {{ source('landing', 'employees') }}

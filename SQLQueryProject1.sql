/*
select all the data
*/
select*
from Project1..CovidDeaths
where continent is not null
order by 3,4

/*
select data that we are using
*/
select location, date, total_cases, new_cases, total_deaths, population
from Project1..CovidDeaths
where continent is not null
order by 1,2

-- total cases vs total deaths
--shows likelihood of dying is you contract in your country #Nigeria as case study
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
from Project1..CovidDeaths
where location like '%Nigeria%' and continent is not null


--looking at total cases vs population
--percentage that got covid
select location, date, total_cases, population, (total_cases/population)*100 as PercentageInfected
from Project1..CovidDeaths
where continent is not null and location like'%Nigeria%'
order by 1,2


--looking at countries with highest infection per population
select location, population, Max(total_cases) as HighestInfectionRate,Max(total_cases/population)*100 as
PercentagePopulationInfected
from Project1..CovidDeaths
where continent is not null 
Group by location, population
--order by HighestInfectionRate Desc
order by percentagepopulationinfected desc


--showing continent with highest deathrates per population
select continent, Max(cast(total_deaths as int)) as TotalDeath
from Project1..CovidDeaths
where continent is not null
group by continent
order by TotalDeath desc

--Global Numbers
select date, sum(new_cases) as TotalNewCases, sum(cast(new_deaths as int))as TotalNewDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from Project1..CovidDeaths
--where location like '%Nigeria%' 
where continent is not null
group by date
order by Deathpercentage desc

--Creating view to store data
create view 
DeathPe as
select date, sum(new_cases) as TotalNewCases, sum(cast(new_deaths as int))as TotalNewDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from Project1..CovidDeaths
--where location like '%Nigeria%' 
where continent is not null
group by date

